import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spotify/spotify.dart' as spotify;

class Leftbar extends StatefulWidget {
  final spotify.Pages? pages;
  const Leftbar({super.key, required this.pages});

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
                            for (var playlist in snapshot.data)
                              ListTile(
                                  title: Text(playlist.name),
                                  leading: Image(
                                      image: NetworkImage(
                                          playlist.images!.first.url))),
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
