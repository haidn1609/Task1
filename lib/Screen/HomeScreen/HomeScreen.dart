import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task1/value/colors.dart';
import 'dart:async';
import '../../provider/taskProvider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  var editTextTask = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: GestureDetector(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context)
                  .copyWith(scrollbars: false),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: backGround,
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: TextField(
                                  controller: editTextTask,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "Nhập task của bạn"),
                                  showCursor: false,
                                  autofocus: true,
                                  autocorrect: true,
                                  enabled: false,
                                ),
                              )),
                          flex: 3,
                        ),
                        Expanded(
                          child: Center(
                              child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: IconButton(
                                      onPressed: () {
                                        // value.addList(editTextTask.text);
                                        // editTextTask.clear();
                                        // // FocusManager.instance.primaryFocus?.unfocus();
                                        // FocusScope.of(context).unfocus();
                                        // print(editTextTask.text);
                                      },
                                      icon: Icon(Icons.add_circle_outline)))),
                          flex: 1,
                        ),
                        Expanded(
                          child: Center(
                              child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: IconButton(
                                      onPressed: () {
                                        // value.removeList(
                                        //     value.listTasks.length - 1);
                                      },
                                      icon: Icon(
                                          Icons.remove_circle_outline)))),
                          flex: 1,
                        )
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 50, right: 50),
                        child: ElevatedButton(
                            onPressed: () {
                              // Navigator.pushNamed(context, '/SelectImage');
                            },
                            child: Center(
                              child: Text("Chọn ảnh từ thư viện"),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: buttonColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(color: borDerColor))))),
                    Container(
                        margin: EdgeInsets.only(left: 50, right: 50),
                        child: ElevatedButton(
                            onPressed: () {
                              // Navigator.pushNamed(context, '/ScanQrCode');
                            },
                            child: Center(
                              child: Text("Scan Qr Code"),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: buttonColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(color: borDerColor))))),
                    Container(
                        margin: EdgeInsets.only(left: 50, right: 50),
                        child: ElevatedButton(
                            onPressed: () {
                              value.clearListBase64();
                              value.setCurentDoc(-1);
                              Navigator.pushNamed(context, '/ScanDoc');
                            },
                            child: Center(
                              child: Text("Scan Doccument"),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: buttonColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(color: borDerColor))))),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Center(
                          child: value.listDoc.isEmpty
                              ? Container(
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: Text("Chưa có task"),
                            ),
                          )
                              : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: value.listDoc.length,
                              itemBuilder: (context, index) =>
                                  GestureDetector(
                                    onTap: () {
                                      print("click index ${index} have ${value.listDoc.elementAt(index).length}");
                                      value.setCurentDoc(index);
                                      value.setBase64(value.listDoc.elementAt(index));
                                      Navigator.pushNamed(context, '/ScanDoc');
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black,
                                              width: 1),
                                          borderRadius:
                                          BorderRadius.circular(30),
                                          color: backGroundItem),
                                      child: Center(
                                        child: Text(index.toString()),
                                      ),
                                    ),
                                  ))),
                    )
                  ],
                ),
              ),
            ),
            onTap: () {
              FocusScope.of(context).unfocus();
            },
          ),
        );
      },
    );
  }
}
