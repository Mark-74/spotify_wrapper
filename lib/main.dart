import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_wrapper/homepage/homepage.dart';
import 'package:window_manager/window_manager.dart';
import 'package:spotify_wrapper/connect.dart';
import 'package:spotify/spotify.dart';
import  'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:spotify_wrapper/test.dart';

class MyWindowListener extends WindowListener{
  @override
  void onWindowResize() async {
    Size current = await WindowManager.instance.getSize();
    current.width < 1000 || current.height < 800 ? WindowManager.instance.setMinimumSize(const Size(1000, 800)): null;
  }
}

SpotifyApiCredentials? credentials;

void main() async {

  //window settings
  
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowManager.instance.setTitle('Spotify Wrapper');
  WindowManager.instance.setMinimumSize(const Size(1000, 800));
  WindowManager.instance.addListener(MyWindowListener());
  
  //end window settings

  const storage = FlutterSecureStorage();
  String creds = (await storage.read(key: 'credentials'))!;
  var splitted = creds.split('#');
  splitted[4].replaceAll('[', '');
  splitted[4].replaceAll(']', '');
  credentials = SpotifyApiCredentials(splitted[0], splitted[1], accessToken: splitted[2], refreshToken: splitted[3], scopes: splitted[4].split(','), expiration: DateTime.parse(splitted[5]));

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
        routes: {'/': (context) => Homepage(creds: credentials!,),
        '/connect' : (context) => const Connect()});
  }
}
