import 'package:busgo/admin/admin_screen.dart';
import 'package:busgo/authentication/auth_form.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const routeName = "/login";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const AuthForm(),
    );
  }
}
