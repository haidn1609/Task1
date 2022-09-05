import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task1/Screen/HomeScreen/HomeScreen.dart';
import 'package:task1/Screen/ScanDocScreen/ScanDocScreen.dart';
import 'package:task1/Screen/ScanQRCodeScreen/ScanQrCodeScreen.dart';
import 'package:task1/Screen/SelectImageScreen/SelectImageScreen.dart';
import 'package:task1/Screen/SplashScreen/SplashScreen.dart';
import 'package:task1/provider/taskProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openBox("testBox");

  runApp(ChangeNotifierProvider(
      create: (context) => TaskProvider(), child: MyApp()));

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "My app",
        routes: <String, WidgetBuilder>{
          '/HomeScreen': (BuildContext context) => new HomeScreen(),
          '/SelectImage': (BuildContext context) => new SelectImage(),
          '/ScanQrCode': (BuildContext context) => new ScanQrCodeScreen(),
          '/ScanDoc': (BuildContext context) => new ScanDocScreen(),
        },
        //initialRoute: "/",
        home: SplashScreen());
  }
}
