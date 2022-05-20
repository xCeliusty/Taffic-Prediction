import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class RatingDriver extends StatefulWidget {
  const RatingDriver({Key? key}) : super(key: key);

  @override
  _RatingDriverState createState() => _RatingDriverState();
}

class _RatingDriverState extends State<RatingDriver> {
  double value = 3.5;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rating',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Rating'),
          backgroundColor: Colors.blueGrey,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(children: [
              Image.asset(
                'assets/profile.jpeg',
                scale: 12.2,
              ),
              Text(
                "Rola",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Mouse Memoirs',
                  fontSize: 35,
                  color: Color(0xFF383535),
                ),
              ),
            ]),
            Column(
              children: [
                Text(
                  "Enter a compliement?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Mouse Memoirs',
                    fontSize: 35,
                    color: Colors.blueGrey,
                  ),
                ),
                TextFormField(
                  //controller: _destinationController,
                  decoration: InputDecoration(hintText: 'Enter a compliement'),
                  onFieldSubmitted: (value) {
                    print(value);
                  },
                ),
              ],
            ),
            Center(
              child: RatingStars(
                value: value,
                onValueChanged: (v) {
                  //
                  setState(() {
                    value = v;
                  });
                },
                starBuilder: (index, color) => Icon(
                  Icons.star_border_sharp,
                  color: color,
                ),
                starCount: 5,
                starSize: 50,
                valueLabelColor: const Color(0xff9b9b9b),
                valueLabelTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 15.0),
                valueLabelRadius: 10,
                maxValue: 5,
                starSpacing: 2,
                maxValueVisibility: true,
                valueLabelVisibility: true,
                animationDuration: Duration(milliseconds: 1000),
                valueLabelPadding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                valueLabelMargin: const EdgeInsets.only(right: 8),
                starOffColor: const Color(0xFF4B618F),
                starColor: Colors.yellow,
              ),
            ),
            Row(
              children: [
                ButtonBar(
                  children: [
                    //  TextButton(onPressed: () {}, child: Text("Cancle")),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.pushNamed(context, '/FromTo');
                      },
                      child: Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.pushNamed(context, '/FromTo');
                      },
                      child: Text("Confirm"),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
