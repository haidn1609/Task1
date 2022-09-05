import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:task1/provider/taskProvider.dart';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:document_scanner_flutter/configs/configs.dart';

class ScanDocScreen extends StatefulWidget {
  @override
  _ScanDocScreenState createState() {
    return _ScanDocScreenState();
  }
}

class _ScanDocScreenState extends State<ScanDocScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var provider = Provider.of<TaskProvider>(context, listen: false);
    if (provider.curentDoc != -1) {
      provider.setBase64(provider.listDoc.elementAt(provider.curentDoc));
    }
  }

  Future _showDialogSave(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Consumer<TaskProvider>(
          builder: (context, value, child) => AlertDialog(
            title: const Text(
                "Bạn chưa thêm ảnh có chắc chắn muốn lưu danh sách không?"),
            actions: [
              TextButton(
                  onPressed: () {
                    value.addDoc();
                    Navigator.pushNamed(context, '/HomeScreen');
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

  Future _showDialogCancel(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Consumer<TaskProvider>(
          builder: (context, value, child) => AlertDialog(
            title: const Text(
                "Bạn chưa bấm lưu ảnh bạn chắc chắn muốn thoát chứ?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/HomeScreen');
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
      builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Scan doc"),
            leading: IconButton(
                onPressed: () {
                  if ((value.curentDoc == -1 && value.listBase64.isNotEmpty) ||
                      (value.curentDoc != -1 &&
                          value.listBase64.length >
                              value.listDoc
                                  .elementAt(value.curentDoc)
                                  .length)) {
                    _showDialogCancel(context);
                  } else {
                    Navigator.pushNamed(context, '/HomeScreen');
                  }
                },
                icon: const Icon(CupertinoIcons.back)),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    if (value.listBase64.isEmpty) {
                      _showDialogSave(context);
                    } else {
                      value.addDoc();
                      Navigator.pushNamed(context, '/HomeScreen');
                    }
                  },
                  icon: Icon(Icons.save)),
            ],
          ),
          body: ListView(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    File? scan;
                    try {
                      scan = await DocumentScannerFlutter.launch(context,
                          source: ScannerFileSource.GALLERY,
                          labelsConfig: {
                            ScannerLabelsConfig.ANDROID_NEXT_BUTTON_LABEL:
                                "Next Step",
                            ScannerLabelsConfig.ANDROID_SAVE_BUTTON_LABEL:
                                "Save It",
                            ScannerLabelsConfig.ANDROID_ROTATE_LEFT_LABEL:
                                "Turn it left",
                            ScannerLabelsConfig.ANDROID_ROTATE_RIGHT_LABEL:
                                "Turn it right",
                            ScannerLabelsConfig.ANDROID_ORIGINAL_LABEL:
                                "Original",
                            ScannerLabelsConfig.ANDROID_BMW_LABEL: "B & W"
                          });
                      // `scannedDoc` will be the image file scanned from scanner
                    } on PlatformException catch (e) {}
                    if (scan != null) {
                      final bytes = scan.readAsBytesSync();
                      String base64 =
                          "data:image/png;base64," + base64Encode(bytes);
                      value.addBase64(base64);
                      await scan.delete();
                    }
                  },
                  child: const Text("select from galery")),
              ElevatedButton(
                  onPressed: () async {
                    File? scan;
                    try {
                      scan = await DocumentScannerFlutter.launch(context,
                          source: ScannerFileSource.CAMERA,
                          labelsConfig: {
                            ScannerLabelsConfig.ANDROID_NEXT_BUTTON_LABEL:
                                "Next Step",
                            ScannerLabelsConfig.ANDROID_SAVE_BUTTON_LABEL:
                                "Save It",
                            ScannerLabelsConfig.ANDROID_ROTATE_LEFT_LABEL:
                                "Turn it left",
                            ScannerLabelsConfig.ANDROID_ROTATE_RIGHT_LABEL:
                                "Turn it right",
                            ScannerLabelsConfig.ANDROID_ORIGINAL_LABEL:
                                "Original",
                            ScannerLabelsConfig.ANDROID_BMW_LABEL: "B & W"
                          });
                      // `scannedDoc` will be the image file scanned from scanner
                    } on PlatformException catch (e) {}
                    if (scan != null) {
                      final bytes = scan.readAsBytesSync();
                      String base64 =
                          "data:image/png;base64," + base64Encode(bytes);
                      value.addBase64(base64);
                      await scan.delete();
                    }
                  },
                  child: const Text("select from camera")),
              (value.listBase64.isEmpty)
                  ? const Center(child: Text("not select"))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: value.listBase64.length,
                      itemBuilder: (context, index) => Container(
                        padding: const EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.width * 0.6 * 2,
                        child: Image.memory(
                          Uri.parse(value.listBase64.elementAt(index))
                              .data!
                              .contentAsBytes(),
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    )
            ],
          )),
    );
  }
}
