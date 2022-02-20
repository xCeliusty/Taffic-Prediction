import 'package:busgo/authentication/auth_form.dart';
import 'package:busgo/authentication/auth_screen.dart';
import 'package:busgo/drawer/drawer.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  static const routeName = "/dashboard";
  
  void _showDialog() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushNamed(AuthScreen.routeName);
    });
  }

  @override
  void initState() {
    super.initState();
      _showDialog();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'TRAFFIC PREDICTION',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
