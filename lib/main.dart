import 'dart:async';

import 'package:animator/animator.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';
import 'package:shoppingapp/apps/page1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/apps/page2.dart';
import 'api project/home page.dart';
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
