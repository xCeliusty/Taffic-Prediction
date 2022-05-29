import 'package:fastroute/authentication/auth_screen.dart';
// import 'package:fastroute/pages/calender.dart';\
import 'package:fastroute/pages/traffic_ui.dart';

import 'package:fastroute/screens/maps.dart';
import 'package:fastroute/pages/splash_screen.dart';
import 'package:fastroute/pages/edit_profile.dart';
import 'package:fastroute/screens/test.dart';
import 'package:fastroute/sevices/traffic_service.dart';
// import 'package:fastroute/services/traffic_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/maps.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'screens/statistics.dart';
import 'screens/read_features_csv.dart';
import 'package:get/get.dart';
//import 'package:weather_app/pages/home/home_screen.dart';
import 'weather/pages/home/home_screen.dart';
import 'weather/utils/Binding/HomeBinding.dart';


Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await firebase_core.Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TrafficService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.white,
      ),
       initialRoute: '/',
       routes: {
        AuthScreen.routeName: (BuildContext context) {
          return const AuthScreen();
        },

        
       Editprofile.routeName: (context) => Editprofile(),
         Statistics.routeName: (context) => Statistics(),

        '/TrafficSummary': (context) => TrafficSummaryScreen(),
        '/FromTo': (context) => FromTo(),
        '/Query': (context) => Query(),
       },
       getPages: [

        GetPage(
          name: '/weather',
          page: () => HomeScreen(),
          binding: HomeBinding(),

        )
      ],
      home: Splash(),
    );
//       routes: {
//         AuthScreen.routeName: (BuildContext context) {
//           return const AuthScreen();
//         },

        
//        Editprofile.routeName: (context) => Editprofile(),
//          Statistics.routeName: (context) => Statistics(),

//         '/TrafficSummary': (context) => TrafficSummaryScreen(),
//         '/FromTo': (context) => FromTo(),
//         '/Query': (context) => Query(),
//      //   page: () => HomeScreen(),
// //  binding: HomeBinding(),
        


//       },
     
    //   home: FromTo(),
    
  }
}

