import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Traffic {
  double? level;


  Traffic({
    this.level,

  });

  factory Traffic.fromJson(Map<String, dynamic> json) {
    return Traffic(
      level: json['data'],
    );
  }
}
