import 'package:flutter/material.dart';
import 'package:ign_mobile_flutter/screens/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
           primary: const Color(0xFFC02E21),
        ), //C02E21
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

