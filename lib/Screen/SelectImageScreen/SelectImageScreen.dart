import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:task1/provider/taskProvider.dart';
import 'dart:async';
import '../../value/colors.dart';
import 'dart:io';

class SelectImage extends StatefulWidget {
  @override
  _SelectImageState createState() {
    return _SelectImageState();
  }
}

class _SelectImageState extends State<SelectImage> {
  File? image;

  Future imagePick() async {
    final picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    print(picture?.path);
    setState(() {
      image = File(picture!.path);
    });
  }

  Future cameraPick() async {
    final picture = await ImagePicker().pickImage(source: ImageSource.camera);
    print(picture?.path);
    setState(() {
      image = File(picture!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Select Text"),
            leading: IconButton(
                onPressed: () {
                  if (image != null) {
                    value.addList(image!.path);
                  }
                  Navigator.pushNamed(context, '/HomeScreen');
                },
                icon: Icon(CupertinoIcons.back)),
          ),
          body: ListView(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 50, right: 50),
                  child: ElevatedButton(
                      onPressed: () => imagePick(),
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
                      onPressed: () => cameraPick(),
                      child: Center(
                        child: Text("Chọn ảnh từ Camera"),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: buttonColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: borDerColor))))),
              image != null
                  ? Image.file(
                      image!,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.contain,
                    )
                  : FlutterLogo(
                      size: 160,
                    )
            ],
          )),
    );
  }
}
