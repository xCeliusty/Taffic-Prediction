import 'package:fastroute/authentication/auth_screen.dart';
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
    return   
     Scaffold(
        body: Center(
          child: Column(
            children: [
              Center(
                child: Text(
                  '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                  
                ),
              ),
               ClipRRect(
                                      //borderRadius: new BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/app_logo.png',
                                       // height: 50,
                                      ),
                                    ),
            ],
          ),
        ),
    );
  }
}
