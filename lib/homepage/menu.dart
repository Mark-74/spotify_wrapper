import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:spotify_wrapper/homepage/menu.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_wrapper/homepage/updater.dart';
import 'package:spotify_wrapper/homepage/searchpage.dart';
import 'package:spotify/spotify.dart' as sp;

Future<List<Container>> convertRecentTracks(sp.CursorPages<sp.PlayHistory> history, PlayerNotifier pn) async {
  final spotify = sp.SpotifyApi(sp.SpotifyApiCredentials(dotenv.get('CLIENT_ID'), dotenv.get('CLIENT_SECRET')));
  var result = await history.all();
  List<Container> list = [];
  for(var element in result) {
    sp.Track currentTrack = await spotify.tracks.get(element.track!.id!);
    list.add(Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            IconButton(
              icon: Image(
              image: NetworkImage(currentTrack.album!.images!.first.url!),
              height: 148,
            ), 
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onPressed: () {
                pn.notify(currentTrack.id!, currentTrack.artists!.first.name!);
              },),
            
            Text(currentTrack.name!),
          ],
        ),
      ),
    ));
  }
  return list;
}

Future<List<Container>> convertArtists(sp.Pages<sp.Artist> artists) async {
  var result = await artists.all();
  List<Container> list = [];
  for(var element in result) {
    list.add(Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image(
              image: NetworkImage(element.images!.first.url!),
              height: 150,
            ),
            Text(element.name!),
          ],
        ),
      ),
    ));
  }
  return list;
}

Future<List<Container>> convertTracks(sp.Pages<sp.Track> topTracks, PlayerNotifier pn) async {
  var result = await topTracks.all(30);
  List<Container> list = [];
  for(var element in result) {
    list.add(Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            IconButton(
              icon: Image(image: NetworkImage(element.album!.images!.first.url!), height: 148,),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onPressed: () {
                pn.notify(element.id!, element.artists!.first.name!);
              },
            ),
            Text(element.name!),
          ],
        ),
      ),
    ));
  }
  return list;
}

class CenterMenu extends StatefulWidget {
  final sp.CursorPages<sp.PlayHistory> playHistory;
  final sp.Pages<sp.Artist> topArtists;
  final sp.Pages<sp.Track> topTracks;
  final PlayerNotifier trackUpdater;
  const CenterMenu({super.key, required this.playHistory, required this.topArtists, required this.topTracks, required this.trackUpdater});

  @override
  State<CenterMenu> createState() => _CenterMenuState();
}

class _CenterMenuState extends State<CenterMenu> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Search bar
            Center(
              child: SizedBox(
                width: 600,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: ' 🔍 Search your songs',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    hintStyle: const TextStyle(color: Colors.white54),
                  ),
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Searchpage(playerNotifier: widget.trackUpdater,))),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Recently played",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: FutureBuilder(
                  future: convertRecentTracks(widget.playHistory, widget.trackUpdater),
                  builder: (context, child) {
                    if (child.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: child.data!.length,
                        itemBuilder: (context, index) {
                          return child.data![index];
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
            ),
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Your favourite artists",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: FutureBuilder(
                  future: convertArtists(widget.topArtists),
                  builder: (context, child) {
                    if(child.hasData){
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: child.data!.length,
                        itemBuilder: (context, index) {
                          return child.data![index];
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
            ),
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Your top songs",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: FutureBuilder(
                  future: convertTracks(widget.topTracks, widget.trackUpdater),
                  builder: (context, child) {
                    if(child.hasData){
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: child.data!.length,
                        itemBuilder: (context, index) {
                          return child.data![index];
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    ));
  }
}
