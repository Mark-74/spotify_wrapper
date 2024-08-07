import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Rightbar extends StatefulWidget {
  final String artist, songName, imageUrl;
  const Rightbar({super.key, required this.artist, required this.imageUrl, required this.songName});

  @override
  State<Rightbar> createState() => _RightbarState();
}

class _RightbarState extends State<Rightbar> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: const BoxDecoration(
            color: Color(0xFF121212),
            border: Border(
              left: BorderSide(width: 0.4, color: Colors.white),
            )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                const DecoratedBox(decoration: BoxDecoration(color: Color(0xFF121212)), child: SizedBox(height: double.infinity, width: double.infinity,),),
                SingleChildScrollView(
                child: Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    SizedBox(
                      child: Image(
                        image: NetworkImage(widget.imageUrl),
                        height: 300,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 40,
                      child: Text(
                        widget.artist,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 40,
                      child: Text(
                        widget.songName,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                                    ),
                ),
              ),]
            ),
          ),
        ));
  }
}
