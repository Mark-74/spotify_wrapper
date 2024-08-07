import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Leftbar extends StatefulWidget {
  const Leftbar({super.key});

  @override
  State<Leftbar> createState() => _LeftbarState();
}

class _LeftbarState extends State<Leftbar> {
  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
          color: Color(0xFF121212),
          border: Border(
            right: BorderSide(width: 0.4, color: Colors.white),
          )),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 15),
                SizedBox(
                  child: Icon(Icons.person, size: 100),
                ),
                SizedBox(height: 15),
                SizedBox(
                  child: Icon(Icons.person, size: 100),
                ),
                SizedBox(height: 15),
                SizedBox(
                  child: Icon(Icons.person, size: 100),
                ),
                SizedBox(height: 15),
                SizedBox(height: 15),
                SizedBox(
                  child: Icon(Icons.person, size: 100),
                ),
                SizedBox(height: 15),
                SizedBox(
                  child: Icon(Icons.person, size: 100),
                ),
                SizedBox(height: 15),
                SizedBox(
                  child: Icon(Icons.person, size: 100),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
