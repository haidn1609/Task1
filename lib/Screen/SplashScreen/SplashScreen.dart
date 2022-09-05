import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:task1/firebase/firestore.dart';

import '../../provider/taskProvider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future timeStand() async {
    print("object");
    var provider = Provider.of<TaskProvider>(context,listen: false);
    provider.setListDocSplash();
    Future.delayed(
      const Duration(seconds: 5),
      () {
        Navigator.pushNamed(context, '/HomeScreen');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    timeStand();
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.blue,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const FlutterLogo(
              size: 50,
            ),
            const Text(
              "Document Scanner App\nIs loading",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontStyle: FontStyle.normal,
                  decoration: TextDecoration.none),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: const SpinKitCircle(
                color: Colors.white,
                size: 25,
              ),
            )
          ],
        ),
      ),
    );
  }
}
