import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task1/provider/taskProvider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:document_scanner_flutter/configs/configs.dart';

class ScanDocScreen extends StatefulWidget {
  @override
  _ScanDocScreenState createState() {
    return _ScanDocScreenState();
  }
}

class _ScanDocScreenState extends State<ScanDocScreen> {
  File? scannedDocument;
  var cameraPermissionFuture = () async {
    await Permission.camera.request();
  };

  @override
  void initState() {
    // TODO: implement initState
    cameraPermissionFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Scan doc"),
            leading: IconButton(
                onPressed: () {
                  if (scannedDocument != null) {
                    value.addList(scannedDocument!.path);
                  }
                  Navigator.pushNamed(context, '/HomeScreen');
                },
                icon: Icon(CupertinoIcons.back)),
          ),
          body: ListView(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    File? scan;
                    try {
                      scan = await DocumentScannerFlutter.launch(context,source: ScannerFileSource.GALLERY,labelsConfig:{
                        ScannerLabelsConfig.ANDROID_NEXT_BUTTON_LABEL : "Next Step",
                        ScannerLabelsConfig.ANDROID_SAVE_BUTTON_LABEL: "Save It",
                        ScannerLabelsConfig.ANDROID_ROTATE_LEFT_LABEL: "Turn it left",
                        ScannerLabelsConfig.ANDROID_ROTATE_RIGHT_LABEL: "Turn it right",
                        ScannerLabelsConfig.ANDROID_ORIGINAL_LABEL: "Original",
                        ScannerLabelsConfig.ANDROID_BMW_LABEL: "B & W"
                      } );
                      // `scannedDoc` will be the image file scanned from scanner
                    } catch (e) {
                      print(e.toString());
                    }
                    if(scan!=null){
                      setState(() {
                        scannedDocument = scan;
                      });
                    }
                  },
                  child: Text("select from galery")),
              ElevatedButton(
                  onPressed: () async {
                    File? scan;
                    try {
                      scan = await DocumentScannerFlutter.launch(context,source: ScannerFileSource.CAMERA,labelsConfig:{
                        ScannerLabelsConfig.ANDROID_NEXT_BUTTON_LABEL : "Next Step",
                        ScannerLabelsConfig.ANDROID_SAVE_BUTTON_LABEL: "Save It",
                        ScannerLabelsConfig.ANDROID_ROTATE_LEFT_LABEL: "Turn it left",
                        ScannerLabelsConfig.ANDROID_ROTATE_RIGHT_LABEL: "Turn it right",
                        ScannerLabelsConfig.ANDROID_ORIGINAL_LABEL: "Original",
                        ScannerLabelsConfig.ANDROID_BMW_LABEL: "B & W"
                      } );
                      // `scannedDoc` will be the image file scanned from scanner
                    } catch (e) {
                      print(e.toString());
                    }
                    if(scan!=null){
                      setState(() {
                        scannedDocument = scan;
                      });
                    }
                  },
                  child: Text("select from camera")),
              (scannedDocument == null) ? Text("not sellect") : Image.file(
                scannedDocument!,
                width: double.infinity,
                height: 400,
                fit: BoxFit.contain,
              ),

            ],
          )),
    );
  }
}
