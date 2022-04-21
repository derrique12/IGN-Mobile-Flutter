import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ign_mobile_flutter/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() async {
    Timer(const Duration(milliseconds: 3000), navigatePage);
  }

  void navigatePage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'assets/logo.png',
            width: MediaQuery.of(context).size.width * 0.7,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
