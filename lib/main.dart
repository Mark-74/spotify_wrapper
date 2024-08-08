import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_wrapper/homepage/homepage.dart';
import 'package:window_manager/window_manager.dart';
//import 'package:spotify_wrapper/test.dart';

class MyWindowListener extends WindowListener{
  @override
  void onWindowResize() async {
    Size current = await WindowManager.instance.getSize();
    current.width < 900 || current.height < 800 ? WindowManager.instance.setMinimumSize(const Size(900, 800)): null;
  }
}

void main() async {

  //window settings
  
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowManager.instance.setTitle('Spotify Wrapper');
  WindowManager.instance.setMinimumSize(const Size(900, 800));
  WindowManager.instance.addListener(MyWindowListener());
  
  //end window settings

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
