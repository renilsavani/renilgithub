import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/cupertino.dart';

import 'api project/loginpage.dart';

void main() {
  runApp(MaterialApp(
    home: splash(),
    builder: EasyLoading.init(),
    debugShowCheckedModeBanner: false,
  ));
}

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4)).then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => loginpage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
              height: 180,
              width: 180,
              child: Lottie.asset('lottiee/36605-shopping-cart.json'))),
    );
  }
}
