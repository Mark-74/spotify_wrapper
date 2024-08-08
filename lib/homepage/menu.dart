import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CenterMenu extends StatefulWidget {
  const CenterMenu({super.key});

  @override
  State<CenterMenu> createState() => _CenterMenuState();
}

class _CenterMenuState extends State<CenterMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              "Playlists",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(10, (index) {
                  return Container(
                    width: 150.0,
                    height: 100,
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    color: Colors.black,
                  );
                }),
              ),
            ),
          ],
        ));
  }
}
