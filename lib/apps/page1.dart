import 'package:animator/animator.dart';
import 'package:flutter/material.dart';

class page1 extends StatefulWidget {
  const page1({Key? key}) : super(key: key);

  @override
  State<page1> createState() => _page1State();
}

class _page1State extends State<page1> with TickerProviderStateMixin {
  AnimationController? controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    child: Animator<double>(
                      duration: Duration(milliseconds: 1000),
                      cycles: 0,
                      curve: Curves.easeInOut,
                      tween: Tween<double>(begin: 15.0, end: 25.0),
                      builder: (context, animatorState, child) => Icon(
                        Icons.list,
                        size: animatorState.value * 2,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                  Container(
                    height: 70,
                    width: 70,
                    child: Animator<double>(
                      duration: Duration(milliseconds: 1000),
                      cycles: 0,
                      curve: Curves.easeInOut,
                      tween: Tween<double>(begin: 15.0, end: 25.0),
                      builder: (context, animatorState, child) => Icon(
                        Icons.shopping_cart,
                        size: animatorState.value * 2,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                  Container(
                    height: 70,
                    width: 70,
                    child: Animator<double>(
                      duration: Duration(milliseconds: 1000),
                      cycles: 0,
                      curve: Curves.easeInOut,
                      tween: Tween<double>(begin: 15.0, end: 25.0),
                      builder: (context, animatorState, child) => Icon(
                        Icons.home,
                        size: animatorState.value * 2,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                ]),
            color: Colors.purple.shade100,
          ),
          Container(
            child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 80),
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.yellow.shade400,
                            borderRadius: BorderRadius.circular(10)),
                      );
                    },
                  ),
                )),
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                color: Colors.pink.shade300,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(55),
                    bottomRight: Radius.circular(55))),
            margin: EdgeInsets.only(bottom: 60),
          ),
          Container(
            width: double.infinity,
            child: Center(
              child: Text("Online Shopping",
                  style: TextStyle(color: Colors.white70, fontSize: 30)),
            ),
            height: double.infinity,
            margin: EdgeInsets.only(bottom: 630),
            decoration: BoxDecoration(
                color: Colors.indigo.shade400,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(55),
                    bottomLeft: Radius.circular(55))),
          )
        ]),
      ),
    );
  }
}
