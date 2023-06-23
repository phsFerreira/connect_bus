import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

final city = <String, String>{
  "name": "Los Angeles",
  "state": "CA",
  "country": "USA"
};
