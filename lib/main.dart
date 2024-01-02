import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jagvault/firebase_options.dart';
import 'package:jagvault/providers/letters_provider.dart';
import 'package:jagvault/providers/user_provider.dart';
import 'package:jagvault/screens/index.dart';
import 'package:jagvault/screens/letters/create_letter.dart';
import 'package:jagvault/screens/login_screen.dart';
import 'package:jagvault/screens/splash_screen.dart';
import 'package:jagvault/services/auth_service.dart';
import 'package:jagvault/services/letters_service.dart';
import 'package:jagvault/services/music_service.dart';
import 'package:provider/provider.dart';

import 'screens/songs/songs_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => AuthenticationService(_firebaseAuth)),

        //letters
        ChangeNotifierProvider(create: (_) => LettersProvider()),
        ChangeNotifierProvider(create: (_) => LettersService()),

        //users
        ChangeNotifierProvider(create: (_) => UserProvider()),

        //music
        Provider(create: (_) => MusicApiProvider()),
        ChangeNotifierProvider(create: (_) => SongsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => LoginScreen(),
          '/main': (context) => const MainScreen(),
          '/create_letter': (context) => const CreateLetter(),
        },
        initialRoute: '/',
      ),
    );
  }
}
