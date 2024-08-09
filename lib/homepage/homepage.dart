import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:spotify/spotify.dart';
import 'package:spotify_wrapper/homepage/leftbar.dart';
import 'package:spotify_wrapper/homepage/menu.dart';
import 'package:spotify_wrapper/homepage/rightbar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

Map<String, String> getCredentials() {
  return {
    'client_id': dotenv.get('CLIENT_ID'),
    'client_secret': dotenv.get('CLIENT_SECRET')
  };
}

class Updater with ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}

class Homepage extends StatefulWidget {
  Homepage({super.key});

  final Map<String, String> credentials = getCredentials();
  final player = AudioPlayer();

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final Updater trackUpdater = Updater();
  final Updater buttonUpdater = Updater();
  late AudioPlayer player = widget.player;
  Track? currentTrack;
  Duration? duration;
  Pages? playlists;

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  void initState() {
    player.onPlayerStateChanged.listen((event) {
      if(event == PlayerState.playing) trackUpdater.notify();
      buttonUpdater.notify();
    });

    final spotify = SpotifyApi(SpotifyApiCredentials(
        widget.credentials['client_id'], widget.credentials['client_secret']));
    spotify.tracks
        .get('18lR4BzEs7e3qzc0KVkTpU?si=27d68fc2c2dd40da')
        .then((track) async {
      String? songName = track.name;
      if (songName != null) {
        currentTrack = track;
        final yt = YoutubeExplode();
        final video = (await yt.search.search(songName)).first;
        final videoId = video.id.value;
        duration = video.duration;
        var manifest = await yt.videos.streamsClient.getManifest(videoId);
        var audioUrl = manifest.audioOnly.first.url;
        await player.play(UrlSource(audioUrl.toString()));
      }
    });
    playlists = spotify.playlists.getUsersPlaylists(dotenv.get('USER_ID'));
    CursorPages<PlayHistory> history = spotify.me.recentlyPlayed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Row(
              children: [
                // Left column
                Expanded(
                  flex: 2,
                  child: Leftbar(pages: playlists),
                ),
                // Center body
                const Expanded(
                  flex: 8,
                  child: CenterMenu(),
                ),

                // Right column
                Expanded(
                  flex: 3,
                  child: ListenableBuilder(
                    listenable: trackUpdater,
                    builder: (context, child) {
                      if (currentTrack == null) {
                        return const DecoratedBox(
                          decoration: BoxDecoration(color: Color(0xFF121212)),
                          child: SizedBox(
                            height: double.infinity,
                          ),
                        );
                      }
                      return Rightbar(
                          artist: currentTrack!.artists!.first.name!,
                          songName: currentTrack!.name!,
                          imageUrl: currentTrack!.album!.images!.first.url!);
                    },
                  ),
                ),
              ],
            ),
          ),
          // Bottom row
          Expanded(
              flex: 2,
              child: BottomAppBar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListenableBuilder(
                              listenable: buttonUpdater,
                              builder: (context, child) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.skip_previous,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        if (player.state == PlayerState.playing) {
                                          await player.pause();
                                        } else {
                                          await player.resume();
                                        }
                                      },
                                      icon: Icon(
                                        player.state == PlayerState.playing
                                            ? Icons.pause
                                            : Icons.play_circle_filled,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.skip_next,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    ),
                                  ],
                                );
                              }
                            ),
                          ),
                          StreamBuilder(
                              stream: player.onPositionChanged,
                              builder: (context, data) {
                                return ProgressBar(
                                  progress:
                                      data.data ?? const Duration(seconds: 0),
                                  total: duration ?? const Duration(minutes: 4),
                                  bufferedBarColor: Colors.white38,
                                  baseBarColor: Colors.white10,
                                  thumbColor: Colors.white,
                                  timeLabelTextStyle:
                                      const TextStyle(color: Colors.white),
                                  progressBarColor: Colors.white,
                                  onSeek: (duration) {
                                    player.seek(duration);
                                  },
                                );
                              }),
                        ],
                      ),
                    ),
                    const Expanded(flex: 1, child: SizedBox())
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
