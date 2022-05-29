import 'package:fastroute/authentication/auth_screen.dart';
import 'package:fastroute/pages/edit_profile.dart';
import 'package:fastroute/pages/edit_profile.dart';
import 'package:fastroute/screens/maps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../weather/pages/home/home_screen.dart';
import '../weather/utils/Binding/HomeBinding.dart';

// import '../pages/calender.dart';

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
              // Navigator.of(context).pushNamed(FromTo.routeName);
              Navigator.pushNamed(context, '/FromTo');
            },
          ),
          ListTile(
            leading: const Icon(Icons.place_outlined),
            title: const Text("Predict Traffic"),
            onTap: () {
              // Navigator.of(context).pushNamed(FromTo.routeName);
              Navigator.pushNamed(context, '/Query');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile Setting"),
            onTap: () {
             Navigator.of(context).pushNamed(Editprofile.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.air),
            title: const Text("Weather"),
            onTap: () {
              // Navigator.of(context).pushNamed(Calender.routeName);
              Navigator.pushNamed(context,'/weather' );
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
