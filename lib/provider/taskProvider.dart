import 'package:flutter/cupertino.dart';

class TaskProvider extends ChangeNotifier {
  //value field
  List<String> listTasks = [];
  //method fiel
  void addList(String task) {
    listTasks.add(task);
    notifyListeners();
  }

  void removeList(int index) {
    listTasks.removeAt(index);
    notifyListeners();
  }
}
