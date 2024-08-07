import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UpperBar extends StatefulWidget {
  const UpperBar({super.key});

  @override
  State<UpperBar> createState() => _UpperBarState();
}

class _UpperBarState extends State<UpperBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Spotify Wrapper"),
      actions: <Widget>[
        IconButton(
          alignment: Alignment.centerRight,
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
      ],
    );
  }
}
