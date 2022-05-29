import 'package:fastroute/admin/admin_screen.dart';
import 'package:fastroute/authentication/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:fastroute/drawer/drawer.dart';

import '../models/traffic.dart';
import '../sevices/traffic_service.dart';

class Query extends StatefulWidget {
  static const routeName = "/test";

  State<Query> createState() => QueryState();
}

class QueryState extends State<Query> {
  static const routeName = "/qeury";
  String QueryText = 'No Traffic Records';
  @override
  Widget build(BuildContext context) {
    TrafficService trafficService =
        Provider.of<TrafficService>(context, listen: true);

    dynamic url =
        "http://192.168.43.133:5000/predict?Date=02/04/2022&CodedDay=7&Zone=5&Weather=16&Temperature=12.1&Rain=1&Holiday=0";
    var Data;

    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text('Check Today Traffic'),
          backgroundColor: Colors.blueGrey,
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 0),
              child: TextField(
                // onChanged: (value) {
                //   url = 'http://127.0.0.1:9000/predict?Date=' + value.toString();
                // },
                decoration: new InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.blueGrey,
                  ),
                  enabledBorder: OutlineInputBorder(
                    // width: 0.0 produces a thin "hairline" border
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Colors.blueGrey, width: 5.0),
                  ),
                  border: const OutlineInputBorder(),
                  labelStyle: new TextStyle(
                    color: Colors.blueGrey,
                  ),
                  hintText: "Check Today Traffic",
                ),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  height: 0.01,

                  //width:
                ),

                // decoration: InputDecoration(
                //     hintText: 'Search Anything Here',
                //     suffixIcon: GestureDetector(
                //         // behavior: HitTestBehavior.translucent,
                //         // onTap: () async {
                //         //   // Data = await Getdata(url);
                //         //   var DecodedData = jsonDecode(Data);
                //         //   setState(() {
                //         //     QueryText = DecodedData;
                //         //   });
                //         // },
                //         child: Icon(Icons.search),),),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: Colors.blueGrey,
                    onSurface: Colors.grey,
                    side: BorderSide(
                        color: Color.fromARGB(255, 2, 97, 145), width: 2),
                    elevation: 10,
                    minimumSize: Size(150, 50),
                  ),
                  onPressed: () {
                    // Data = await Getdata(url);
                    // var DecodedData = jsonDecode(url);
                    // print("Decoded is "+DecodedData);
                    // print('object');
                    setState(() {
                      // List<Traffic> traffic = trafficService.getTraffic();
                      // print(traffic[0].level);
                      Future.delayed(Duration(seconds: 0), () async {
                        trafficService.fetchTraffic().then((value) {
                          List<Traffic> traffic = trafficService.getTraffic();
                          print("test");
                          // print(traffic[0].level);
                          if (traffic[0].level != 3) {
                            QueryText = "ETA is apx. " + traffic[0].level.toString() + " Minutes";
                          }
                        });
                      });

                      // QueryText = DecodedData['data'];
                    });
                  },
                  child: Text('Search')),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  QueryText.toString(),
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ), //Text
              ),
            ),
          ],
        ));
    // MaterialApp
  }
}
