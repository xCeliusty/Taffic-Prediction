

import 'package:busgo/authentication/auth_screen.dart';
import 'package:busgo/pages/edit_profile.dart';
import 'package:busgo/pages/edit_profile.dart';

import 'package:busgo/screens/maps.dart';
import 'package:busgo/pages/edit_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("TRAFFIC PREDICTION"),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text("Dashboard"),
            onTap: () {
              Navigator.of(context).pushNamed(FromTo.routeName);
              //Navigator.pushNamed(context, '/FromTo');
            },
          ),
          
          
          
        
          
          ListTile(
            leading: const Icon(Icons.remove_red_eye),
            title: const Text("view edit profile"),
            onTap: () {
              
          
              
              Navigator.of(context).pushNamed(Editprofile.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Signout"),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamed(AuthScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
