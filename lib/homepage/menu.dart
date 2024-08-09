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
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  color: Colors.black,
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
