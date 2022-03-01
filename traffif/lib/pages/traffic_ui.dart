import 'package:flutter/material.dart';

class TrafficSummaryScreen extends StatelessWidget {
  const TrafficSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Traffic",
          style: TextStyle(color: Colors.white),
        ),
        // centerTitle: true,
        elevation: 2.0,

        backgroundColor: Colors.blueGrey,
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text("Cairo traffic",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0)),
              SizedBox(
                height: 8.0,
              ),
              Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("CURRENT WEATHER",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0)),
                        SizedBox(
                          height: 12.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.nightlight_round,
                              size: 32.0,
                            ),
                            Text(
                              "14°C",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 26.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("LOCAL TIME",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0)),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text("2:00 AM",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 24.0)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: 16.0,
              ),
              CircleAvatar(
                radius: 80.0,
                backgroundImage: NetworkImage(
                    "https://image.freepik.com/free-photo/aerial-view-empty-intercity-road-sunset-top-view-from-drone-highway-evening_127089-18745.jpg?w=740"),
              ),
              SizedBox(
                height: 16.0,
              ),
              Text("CONGESTION LEVEL NOW",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0)),
              SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 6,
                    backgroundColor: Colors.lightGreen,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text("7%",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 34.0)),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_upward,
                    color: Colors.deepOrange,
                    size: 20,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text("3%",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 34.0)),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text("more than average at this time",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 16.0)),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: 24.0,
              ),
              Text("TRAFFIC JAMS NOW",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 22.0)),
              SizedBox(
                height: 16.0,
              ),
              Text("44",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 32.0)),
              SizedBox(
                height: 4.0,
              ),
              Text("total count",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0)),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
