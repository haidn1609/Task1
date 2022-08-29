import 'dart:ffi';
import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:task1/provider/taskProvider.dart';

class ScanQrCodeScreen extends StatefulWidget {
  @override
  _ScanQrCodeScreenState createState() {
    return _ScanQrCodeScreenState();
  }
}

class _ScanQrCodeScreenState extends State<ScanQrCodeScreen> {
  final GlobalKey key = GlobalKey();
  late QRViewController controller;
  Barcode? result;

  void qr(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((event) {
      setState(() {
        result = event;
      });
    });
  }
  //
  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (controller != null) {
  //     if (Platform.isAndroid) {
  //       controller?.pauseCamera();
  //     }
  //     controller?.resumeCamera();
  //   }
  // }
  //
  // @override
  // void dispose() {
  //   if (controller != null) {
  //     controller?.dispose();
  //   }
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(builder: (context, value, child) => Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("ScanQrCode"),
        leading: IconButton(onPressed: () {
          final result = this.result;
          if (result != null){
            value.addList(result.code.toString());
          }
          Navigator.pop(context);
        }, icon: Icon(CupertinoIcons.back)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 300,
              child: QRView(key: key,
                  onQRViewCreated: qr,
                  overlay: QrScannerOverlayShape()),
              // child: Center(
              //   child:IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt)),
              // ),
            ),
            Container(child: (result != null) ? Text(
              "data: ${result?.code.toString()}",) : Text("Scan code"))
          ],
        ),
      ),
    ),);
  }
}
