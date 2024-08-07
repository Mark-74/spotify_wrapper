import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Rightbar extends StatefulWidget {
  const Rightbar({super.key});

  @override
  State<Rightbar> createState() => _RightbarState();
}

class _RightbarState extends State<Rightbar> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Padding(
      padding: EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 10),
                SizedBox(
                  child: Icon(Icons.person, size: 300),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  child: Text(
                    "songnamesongname",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  child: Icon(Icons.person, size: 300),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  child: Text(
                    "infoinfoinfoinfo",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
