import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

var db = FirebaseFirestore.instance;
FirebaseStorage storage =
    FirebaseStorage.instanceFor(bucket: 'gs://test-project-420b5.appspot.com/');

Future checkStore() async {
  // await db.collection('products').get().then((value) {
  //   print("${value.docs.elementAt(0)['name']}");
  // });
  List<String> lists = [];
  lists.add("base1");
  lists.add("base2");
  lists.add("base3");
  lists.add("base4");
  Map<String, dynamic> base64s = <String, dynamic>{'list64': lists};
// Add a new document with a generated ID
  db.collection("base64s").add(base64s).then((DocumentReference doc) =>
      print('DocumentSnapshot added with ID: ${doc.id}'));
}

Future addBase64(List<String> listBase64) async {
  List<String> lists = listBase64.toList();
  print(lists.elementAt(0).replaceAll(" ", ""));
  Map<String, dynamic> base64s = <String, dynamic>{
    'list64': lists.elementAt(0)
  };
  await db.collection("base64s").add(base64s).then((DocumentReference doc) =>
      print('DocumentSnapshot added with ID: ${doc.id}'));
}
