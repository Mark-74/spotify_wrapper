import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spotify/spotify.dart' as spotify;
import 'package:spotify_wrapper/homepage/playlistpage.dart';
import 'package:spotify_wrapper/homepage/updater.dart';

class Leftbar extends StatefulWidget {
  final spotify.Pages? pages;
  final PlayerNotifier updater;
  const Leftbar({super.key, required this.pages, required this.updater});

  @override
  State<Leftbar> createState() => _LeftbarState();
}

class _LeftbarState extends State<Leftbar> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
          color: Color(0xFF121212),
          border: Border(
            right: BorderSide(width: 0.4, color: Colors.white),
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder(
                  future: widget.pages!.all(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      try {
                        return Column(
                          children: [
                            const Text('Playlists',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 10,
                            ),
                            for (var playlist in snapshot.data)
                              Column(children: [
                                const SizedBox(height: 15),
                                ListTile(
                                    title: Text(playlist.name),
                                    leading: Image(
                                        image: NetworkImage(
                                            playlist.images!.first.url)),
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => PlaylistPage(playlist: playlist, updater: widget.updater)));
                                        },),
                              ])
                          ],
                        );
                      } catch (e) {
                        return const SizedBox();
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
