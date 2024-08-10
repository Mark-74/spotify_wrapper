import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:spotify_wrapper/homepage/menu.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_wrapper/homepage/updater.dart';
import 'package:spotify/spotify.dart' as sp;

Future<List<Container>> convert(sp.CursorPages<sp.PlayHistory> history) async {
  final spotify = sp.SpotifyApi(sp.SpotifyApiCredentials(dotenv.get('CLIENT_ID'), dotenv.get('CLIENT_SECRET')));
  var result = await history.all();
  List<Container> list = [];
  for(var element in result) {
    sp.Track currentTrack = await spotify.tracks.get(element.track!.id!);
    list.add(Container(
      child: Image(
        image: NetworkImage(currentTrack.album!.images!.first.url!),
        height: 150,
      ),
    ));
  }
  return list;
}

class CenterMenu extends StatefulWidget {
  final sp.CursorPages<sp.PlayHistory> playHistory;
  const CenterMenu({super.key, required this.playHistory});

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
              height: 150,
              child: FutureBuilder(
                  future: convert(widget.playHistory),
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
                      return const CircularProgressIndicator();
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
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(10, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: const Icon(
                      Icons.person,
                      size: 150,
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Liked songs",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(10, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: const Icon(
                      Icons.person,
                      size: 150,
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(10, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: const Icon(
                      Icons.person,
                      size: 150,
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(10, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: const Icon(
                      Icons.person,
                      size: 150,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
