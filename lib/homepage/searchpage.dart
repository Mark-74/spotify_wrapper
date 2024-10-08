import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_wrapper/homepage/updater.dart';
import 'package:spotify/spotify.dart' hide Image;

class Searchpage extends StatefulWidget {
  final PlayerNotifier playerNotifier;
  const Searchpage({super.key, required this.playerNotifier});

  @override
  State<Searchpage> createState() => _SearchPageState();
}

class _SearchPageState extends State<Searchpage> {
  final TextEditingController _searchController = TextEditingController();
  final Updater searchUpdater = Updater();
  final spotify = SpotifyApi(SpotifyApiCredentials(
    dotenv.get('CLIENT_ID'),
    dotenv.get('CLIENT_SECRET'),
  ));

  void searchTracks(String query) {
    if (query.length >= 3) {
      setState(() {
        searchUpdater.notify();
      });
    }
  }

  Future<List<Container>> getSearchResults(String query) async {
    final result = await spotify.search.get(query).first();
    List<Container> results = [];

    for (var pages in result) {
      for (var track in pages.items!) {
        if (track is Track) {
          results.add(Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          widget.playerNotifier
                              .notify(track.id!, track.artists!.first.name!);
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        icon: Image(
                          image: NetworkImage(
                              track.album?.images?.first.url ?? ''),
                          fit: BoxFit.cover,
                        )),
                  ),
                  const SizedBox(height: 5),
                  Flexible(
                    child: Text(
                      track.name!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ));
        }
      }
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SearchBar(
          controller: _searchController,
          hintText: ' 🔍 Search your songs',
          onChanged: searchTracks,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListenableBuilder(
                listenable: searchUpdater,
                builder: (context, child) {
                  return FutureBuilder<List<Container>>(
                    future: getSearchResults(_searchController.text),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return snapshot.data![index];
                          },
                        );
                      } else {
                        return const Center(child: Text('No results found'));
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
