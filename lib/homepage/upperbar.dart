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
    return DecoratedBox(
      decoration: const BoxDecoration(
          color: Color(0xFF121212),
          border: Border(
            bottom: BorderSide(width: 0.4, color: Colors.white),
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: IconButton(
                alignment: Alignment.centerRight,
                icon: const Icon(Icons.menu),
                onPressed: () {},
              ),
            ),
            const Text(
              "Spotify Wrapper",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
