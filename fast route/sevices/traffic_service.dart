import 'package:busgo/models/traffic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TrafficService extends ChangeNotifier {
  bool _isLoaded = false;

  List<Traffic> _traffic = [];
  List<Traffic> getTraffic() {
    return _traffic;
  }

  bool getIsLoaded() {
    return _isLoaded;
  }

  Future<void> fetchTraffic() async {
    if (_traffic.length > 0) return;

    final response = await http.get(Uri.parse('http://192.168.1.7:5000/predict?Date=02/04/2022&CodedDay=7&Zone=5&Weather=16&Temperature=12.1&Rain=1&Holiday=0'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var allData = jsonDecode(utf8.decode(response.bodyBytes));

      
      Traffic traffic = Traffic.fromJson(allData);
      _traffic.add(traffic);
      
      _isLoaded = true;
      notifyListeners();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load traffic');
    }
  }
}
