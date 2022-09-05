import 'package:hive/hive.dart';
import 'dart:async';

var box = Hive.box("testBox");

void checkHive() async {
  print("Hive is have ${box.length} item");
}

void addHiveListBase64(int index, List<String> listBase64) async {
  await box.put('$index', listBase64);
}
void removeHiveListBase64(int index) async {
  await box.deleteAt(index);
}
List<List<String>> getAllListHive(){
  List<List<String>>? listBase64Hive = [];
  listBase64Hive = box.values.cast<List<String>>().toList();
  return listBase64Hive;
}
void cleanHive() async {
  await box.clear();
  print("clean success, box have ${box.length} item");
}
