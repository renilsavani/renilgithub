import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';

class page2 extends StatefulWidget {
  const page2({Key? key}) : super(key: key);

  @override
  State<page2> createState() => _page2State();
}

class _page2State extends State<page2> {
  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      drawer: Drawer(),
      title: Text("Welcome"),
      fullyStretchable: true,
      body: [],
      headerWidget: Container(),

    );
  }
}
