import 'package:fastroute/admin/admin_screen.dart';
import 'package:fastroute/authentication/auth_form.dart';
import 'package:fastroute/screens/test.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const routeName = "/login";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(),
    );
  }
}
