import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_wrapper/homepage/homepage.dart';
//import 'package:spotify_wrapper/test.dart';

void main() async {
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    print('Error loading .env file' + e.toString());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF1DB954), brightness: Brightness.dark)),
      home: const SpotifyWrapperApp(),
    );
  }
}

class SpotifyWrapperApp extends StatefulWidget {
  const SpotifyWrapperApp({super.key});

  @override
  State<SpotifyWrapperApp> createState() => _SpotifyWrapperAppState();
}

class _SpotifyWrapperAppState extends State<SpotifyWrapperApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        initialRoute: '/',
        routes: {'/': (context) => Homepage()});
  }
}
