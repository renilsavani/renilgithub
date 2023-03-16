import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoppingapp/api%20project/home%20page.dart';
import 'package:shoppingapp/api%20project/loginpage.dart';
import 'package:http/http.dart' as http;

class addproduct extends StatefulWidget {
  const addproduct({Key? key}) : super(key: key);

  @override
  State<addproduct> createState() => _addproductState();
}

class _addproductState extends State<addproduct>
    with SingleTickerProviderStateMixin {
  List<String> _locations = [
    'car & Motorbike',
    'home & kitchen',
    'Electronics',
    'Jewllery',
    'Books',
    'Toys & Games'
  ]; // Option 2
  String cata = "";
  List<String> warrenty = [
    'Yes',
    'No',
  ];
  String? _selectedLocation;
  String? _selectedwarrenry;
  view? aa;
  final ImagePicker _picker = ImagePicker();
  String img = "";
  String warr = "";
  List addphoto = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 4,
        vsync:
            this); // This would best not to be hard coded, but I saw that you had two tabs...
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  TextEditingController name = TextEditingController();
  TextEditingController bname = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController mrp = TextEditingController();
  TextEditingController que = TextEditingController();
  TextEditingController dis = TextEditingController();
  bool loder = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
              title: Text("upload your product here"),
              bottom: TabBar(controller: _tabController, tabs: [
                Tab(
                  text: "Pro..info",
                ),
                Tab(
                  text: "offer",
                ),
                Tab(
                  text: "Image",
                ),
                Tab(
                  text: "Discription",
                )
              ]),
              backgroundColor: Colors.indigo),
          body: TabBarView(controller: _tabController, children: [
            Container(
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(height: 20),
                  Center(
                      child: Text(
                    "Add Product",
                    style: GoogleFonts.alef(fontSize: 28),
                  )),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Select a product category",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(right: 20, left: 20),
                    child: DropdownButton(
                      hint: Text('Select a category'),
                      // Not necessary for Option 1
                      value: _selectedLocation,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedLocation = newValue!;
                          cata = newValue;
                        });
                      },
                      items: _locations.map((location) {
                        return DropdownMenuItem(
                          child: new Text(location),
                          value: location,
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Product name",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Container(
                      color: Colors.white30.withOpacity(0.2),
                      child: TextField(
                        controller: name,
                        // controller: ,
                        decoration: InputDecoration(
                            hintText: "   smartphone , book , cup",
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Brand name",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Container(
                      color: Colors.white30.withOpacity(0.2),
                      child: TextField(
                        controller: bname,
                        // controller: ,
                        decoration: InputDecoration(
                            hintText: "   zexon , proxin",
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Card(
                        color: Colors.indigo,
                        child: TextButton(
                            onPressed: () {
                              _tabController.animateTo(1);
                            },
                            child: Text(
                              "Next",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16),
                            )),
                      ),
                    ),
                  )
                ]),
              ),
            ),
            Container(
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(height: 40),
                  Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Your price",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 120, left: 20),
                    child: Container(
                      color: Colors.white30.withOpacity(0.2),
                      child: TextField(
                        controller: price,
                        // controller: ,
                        decoration: InputDecoration(
                            hintText: " price ₹",
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Maximum Retail Price",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 120, left: 20),
                    child: Container(
                      color: Colors.white30.withOpacity(0.2),
                      child: TextField(
                        controller: mrp,
                        // controller: ,
                        decoration: InputDecoration(
                            hintText: " M R P   ₹",
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Quentity",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 120, left: 20),
                    child: Container(
                      color: Colors.white30.withOpacity(0.2),
                      child: TextField(
                        controller: que,
                        // controller: ,
                        decoration: InputDecoration(
                            hintText: " 2 / 10",
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Product Warrenty",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(right: 120, left: 20),
                    child: DropdownButton(
                      hint: Text('Warrenty Available'),
                      // Not necessary for Option 1
                      value: _selectedwarrenry,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedwarrenry = newValue!;
                          warr = newValue;
                        });
                      },
                      items: warrenty.map((location) {
                        return DropdownMenuItem(
                          child: new Text(location),
                          value: location,
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Card(
                            color: Colors.indigo,
                            child: TextButton(
                                onPressed: () {
                                  _tabController.animateTo(0);
                                },
                                child: Text(
                                  "Back",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16),
                                )),
                          ),
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Card(
                            color: Colors.indigo,
                            child: TextButton(
                                onPressed: () {
                                  _tabController.animateTo(2);
                                },
                                child: Text(
                                  " Next ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16),
                                )),
                          ),
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            ),
            Container(
              child: Column(children: [
                SizedBox(height: 40),
                Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Add Product image",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 20,
                ),
                DottedBorder(
                    child: InkWell(
                  onTap: () async {
                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    img = image!.path;
                  },
                  child: Container(
                    child: Image.file(File(img), fit: BoxFit.cover),
                    height: 110,
                    width: 110,
                  ),
                )),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Card(
                          color: Colors.indigo,
                          child: TextButton(
                              onPressed: () {
                                _tabController.animateTo(1);
                              },
                              child: Text(
                                "Back",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16),
                              )),
                        ),
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Card(
                          color: Colors.indigo,
                          child: TextButton(
                              onPressed: () {
                                _tabController.animateTo(3);
                              },
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16),
                              )),
                        ),
                      ),
                    ),
                  ],
                )
              ]),
            ),
            Container(
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(height: 20),
                  Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "enter your product Discription",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Container(
                      color: Colors.white30.withOpacity(0.2),
                      child: TextField(
                        maxLines: 13,
                        controller: dis,
                        decoration: InputDecoration(
                            hintText:
                                "   this is the product .... the feture are  ..",
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Card(
                        color: Colors.indigo,
                        child: TextButton(
                            onPressed: () {
                              _tabController.animateTo(2);
                            },
                            child: Text(
                              "Back",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SwipeButton.expand(
                      thumb: Icon(
                        Icons.double_arrow_rounded,
                        color: Colors.white,
                      ),
                      child: Text(
                        "Swipe to Save data",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      activeThumbColor: Colors.indigo,
                      activeTrackColor: Colors.grey.shade300,
                      onSwipe: () async {
                        String id =
                            loginpage.prefs!.getString("userid") ?? "";
                        List<int> imagebyte =
                        File(img).readAsBytesSync();
                        String imagename = base64Encode(imagebyte);
                        print(id);
                        Map addpro = {
                          "useridd": id,
                          "cat": cata,
                          "name": name.text,
                          "bname": bname.text,
                          "price": price.text,
                          "mrp": mrp.text,
                          "que": que.text,
                          "warren": warr,
                          "image": imagename,
                          "dis": dis.text,
                        };

                        var url = Uri.parse(
                            'https://renilflutter.000webhostapp.com/ecomerce/addproduct.php');
                        var response =
                            await http.post(url, body: addpro);
                        print(
                            'Response status: ${response.statusCode}');
                        print('Response body: ${response.body}');
                        var ii = jsonDecode(response.body);
                        aa = view.fromJson(ii);

                        if (aa!.connection == 1) {
                          if (aa!.result == 1) {
                            EasyLoading.dismiss(animation: false);
                            EasyLoading.showSuccess(
                                "Upload sucessfully");
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return homepage();
                                  },
                                ));
                          }
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Swipped sucessfully"),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                    ),
                  )
                ]),
              ),
            )
          ])),
    );
  }
}

class view {
  int? connection;
  int? result;

  view({this.connection, this.result});

  view.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    return data;
  }
}
