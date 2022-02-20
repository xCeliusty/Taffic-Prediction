import 'package:busgo/authentication/auth_form.dart';
import 'package:busgo/authentication/auth_screen.dart';
import 'package:busgo/pages/traffic_ui.dart';

import 'package:busgo/screens/maps.dart';
import 'package:busgo/pages/splash_screen.dart';
import 'package:busgo/pages/edit_profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './screens/maps.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.white,
      ),
      routes: {
        AuthScreen.routeName: (BuildContext context) {
          return const AuthScreen();
        },

        //FromTo.routeName: (context) => const FromTo(),
        Editprofile.routeName: (context) => Editprofile(),

        '/TrafficSummary': (context) => TrafficSummaryScreen(),
        '/FromTo': (context) => FromTo(),
      },
      home: const Splash(),
      //home: FromTo(),
    );
  }
}
