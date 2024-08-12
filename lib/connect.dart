import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';
import 'package:oauth2/oauth2.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:spotify_wrapper/homepage/homepage.dart';

class Connect extends StatefulWidget {
  const Connect({super.key});

  @override
  State<Connect> createState() => _ConnectState();
}

class Updater with ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}

class _ConnectState extends State<Connect> {
  final Updater submitUpdater = Updater();
  AuthorizationCodeGrant? auth;
  Uri? response;
  TextEditingController controller = TextEditingController();
  TextEditingController redirectUriController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          TextField(
            controller: redirectUriController,
          ),
          Center(
            child: TextButton(onPressed: () async{
              auth = SpotifyApi.authorizationCodeGrant(SpotifyApiCredentials(dotenv.get('CLIENT_ID'), dotenv.get('CLIENT_SECRET')));
              response = auth!.getAuthorizationUrl(Uri.parse(redirectUriController.text), scopes: ['user-read-playback-state', 'user-read-recently-played', 'user-read-currently-playing', 'user-modify-playback-state', 'user-follow-read', 'user-top-read']);
              submitUpdater.notify();
            }, child: const Text('connect')),
          ),
          ListenableBuilder(listenable: submitUpdater, builder: (context, child){
            return SelectableText(response.toString());
          }),
          TextField(
            controller: controller,
          ),
          TextButton(
            onPressed: () async {
              final code = controller.text;
              SpotifyApi spotify = SpotifyApi.fromAuthCodeGrant(auth!, code);
              final creds = await spotify.getCredentials();
              var storage = const FlutterSecureStorage();
              await storage.write(key: 'credentials', value: "${creds.clientId}#${creds.clientSecret}#${creds.accessToken}#${creds.refreshToken}#${creds.scopes.toString()}#${creds.expiration}");
              
              Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage(creds: creds)));
            },
            child: const Text('submit'),
          )
        ],
      ),
    );
  }
}