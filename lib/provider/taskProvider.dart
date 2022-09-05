import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:task1/provider/hiveBox.dart';

class TaskProvider extends ChangeNotifier {
  //value field
  List<String> listTasks = [];
  List<String> listBase64 = [];
  List<List<String>> listDoc = [];
  int curentDoc = -1;

  //method fiel
  void addList(String task) {
    listTasks.add(task);
    notifyListeners();
  }

  void removeList(int index) {
    listTasks.removeAt(index);
    notifyListeners();
  }

  Future setBase64(List<String> list) async {
    List<String> lists = list.toList();
    listBase64 = lists;
    notifyListeners();
  }

  void addBase64(String value) {
    listBase64.add(value);
    notifyListeners();
  }

  void clearListBase64() {
    listBase64.clear();
    notifyListeners();
  }

  void setCurentDoc(int value) {
    curentDoc = value;
    notifyListeners();
  }
  void setListDocSplash() async {
    listDoc = getAllListHive();
  }
  void addDoc() {
    List<String> lists = listBase64.toList();
    if (curentDoc == -1) {
      listDoc.add(lists);
      addHiveListBase64(listDoc.length - 1, lists);
    } else {
      // listBase64.replaceRange(0, listBase64.length, listDoc.elementAt(curentDoc));
      listDoc.elementAt(curentDoc).clear();
      listDoc.elementAt(curentDoc).addAll(lists);
      addHiveListBase64(curentDoc, lists);
    }
    notifyListeners();
  }

  void deleteDoc(int index) {
    listDoc.removeAt(index);
    removeHiveListBase64(index);
    notifyListeners();
  }
}
