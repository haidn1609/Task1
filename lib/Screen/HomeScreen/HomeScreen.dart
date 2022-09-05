import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:task1/provider/hiveBox.dart';
import 'package:task1/value/colors.dart';
import 'dart:async';
import '../../firebase/firestore.dart';
import '../../provider/taskProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  var editTextTask = TextEditingController();


  Future _showDialog(BuildContext context, int index) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Consumer<TaskProvider>(
          builder: (context, value, child) => AlertDialog(
            title: const Text("Bạn có muốn xóa danh sách này không?"),
            actions: [
              TextButton(
                  onPressed: () {
                    value.deleteDoc(index);
                    Navigator.pop(context);
                  },
                  child: const Center(
                    child: Text("Có"),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Center(
                    child: Text("Không"),
                  ))
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Document Scanner"),
            actions: [
              IconButton(
                  onPressed: () {
                    value.clearListBase64();
                    value.setCurentDoc(-1);
                    Navigator.pushNamed(context, '/ScanDoc');
                  },
                  icon: const Icon(CupertinoIcons.doc_text_viewfinder))
            ],
            //backgroundColor: ,
          ),
          body: GestureDetector(
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: backGround,
                child: ListView(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          checkHive();
                        },
                        child: Text("Check firebase")),
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
                                          print(
                                              "click index ${index} have ${value.listDoc.elementAt(index).length}");
                                          value.setCurentDoc(index);
                                          value.setBase64(
                                              value.listDoc.elementAt(index));
                                          Navigator.pushNamed(
                                              context, '/ScanDoc');
                                        },
                                        onLongPress: () {
                                          _showDialog(context, index);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(15),
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: backGroundItem),
                                          child: Center(
                                              child: Text(
                                                  "Document $index\nHave : ${value.listDoc.elementAt(index).length} Image")),
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
