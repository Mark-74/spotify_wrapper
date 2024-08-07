import 'package:flutter/material.dart';
import 'package:spotify_wrapper/homepage/bottombar.dart';
import 'package:spotify_wrapper/homepage/leftbar.dart';
import 'package:spotify_wrapper/homepage/menu.dart';
import 'package:spotify_wrapper/homepage/rightbar.dart';
import 'package:spotify_wrapper/homepage/upperbar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: UpperBar(),
          ),

          Expanded(
            flex: 8,
            child: Row(
              children: <Widget>[
                // Left column
                Expanded(
                  flex: 1,
                  child: Leftbar(),
                ),
                // Center body
                Expanded(
                  flex: 5,
                  child: CenterMenu(),
                ),

                // Right column
                Expanded(
                  flex: 2,
                  child: Rightbar(),
                ),
              ],
            ),
          ),
          // Bottom row
          Expanded(
            flex: 1,
            child: Bottombar(),
          ),
        ],
      ),
    );
  }
}
