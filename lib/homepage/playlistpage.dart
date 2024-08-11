import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart' as spotify;
import 'package:spotify_wrapper/homepage/updater.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class PlaylistPage extends StatefulWidget {
  final dynamic playlist;
  final PlayerNotifier updater;
  const PlaylistPage({super.key, required this.playlist, required this.updater});

    @override
    State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  spotify.SpotifyApi sp = spotify.SpotifyApi(spotify.SpotifyApiCredentials(dotenv.get('CLIENT_ID'), dotenv.get('CLIENT_SECRET')));

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Playlist'),
            ),
            body: FutureBuilder(
              future: sp.playlists.getTracksByPlaylistId(widget.playlist.id).all(),
              builder: (context, snapshot) {
                return ListView.builder(
                    itemCount: snapshot.data != null ? snapshot.data!.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                              title: Text(snapshot.data!.elementAt(index).name!),
                              // ignore: sized_box_for_whitespace
                              leading: Container(
                                height: double.infinity,
                                child: Image(
                                    image: NetworkImage(
                                        snapshot.data!.elementAt(index).album!.images!.first.url!)),
                              ),
                              onTap: () {
                                  widget.updater.notify(
                                      snapshot.data!.elementAt(index).id!,
                                      snapshot.data!.elementAt(index).artists!.first.name!,
                                  );
                              },
                          ),
                        );
                    },
                );
              }
            ),
        );
    }
}