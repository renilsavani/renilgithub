import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:badges/badges.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:shoppingapp/api%20project/loginpage.dart';
import 'package:badges/badges.dart' as badges;
import 'package:http/http.dart' as http;

class signuppage extends StatefulWidget {
  const signuppage({Key? key}) : super(key: key);

  @override
  State<signuppage> createState() => _signuppageState();
}

class _signuppageState extends State<signuppage> {
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController ph = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String img = "";
  bool imagee = false;
  final PageController controller = PageController();
  String gender = "";
  bool fnamevalid = false;
  bool lnamevalid = false;
  bool invalid1 = false;
  bool invalid2 = false;
  bool invalid3 = false;
  String fnamee = "";
  String lnamee = "";
  String msg1 = "";
  String msg2 = "";
  String msg3 = "";
  apicall? rr;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/signupbg.jpg"), fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 70,
              ),
              Center(
                child: Container(
                    height: 200,
                    width: 200,
                    child: Lottie.asset("lottiee/105639-signup.json")),
              ),
              Container(
                  height: 400,
                  width: double.infinity,
                  child: PageView(
                    children: [
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: GlassContainer(
                          child: SingleChildScrollView(
                            child: Column(children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text("Sign up",
                                  style: GoogleFonts.nobile(
                                      fontSize: 30, color: Colors.white60)),
                              SizedBox(
                                height: 10,
                              ),
                              Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white60,
                                    radius: 45,
                                    backgroundImage: FileImage(File(img)),
                                  ),
                                  Positioned(
                                    left: 50,
                                    top: 40,
                                    child: IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                backgroundColor:
                                                    Colors.transparent,
                                                actions: [
                                                  GlassContainer(
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          InkWell(
                                                            child: Container(
                                                              child: Lottie.asset(
                                                                  "lottiee/86897-gallery-icon-animation.json"),
                                                              height: 80,
                                                              width: 80,
                                                            ),
                                                            onTap: () async {
                                                              final XFile?
                                                                  image =
                                                                  await _picker
                                                                      .pickImage(
                                                                          source:
                                                                              ImageSource.gallery);
                                                              Navigator.pop(
                                                                  context);
                                                              setState(() {
                                                                img =
                                                                    image!.path;
                                                              });
                                                            },
                                                          ),
                                                          InkWell(
                                                            child: Container(
                                                              child: Lottie.asset(
                                                                  "lottiee/60265-digital-camera.json"),
                                                              height: 80,
                                                              width: 80,
                                                            ),
                                                            onTap: () async {
                                                              final XFile?
                                                                  photo =
                                                                  await _picker
                                                                      .pickImage(
                                                                          source:
                                                                              ImageSource.camera);
                                                              Navigator.pop(
                                                                  context);
                                                              setState(() {
                                                                img =
                                                                    photo!.path;
                                                              });
                                                            },
                                                          ),
                                                          // Lottie.asset(
                                                          //     "lottiee/60265-digital-camera.json")
                                                        ]),
                                                    height: 100,
                                                    width: 300,
                                                    color: Colors.white
                                                        .withOpacity(0.2),
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(
                                          Icons.add_a_photo,
                                          size: 33,
                                          color: Colors.black.withOpacity(0.5),
                                        )),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5, left: 12, right: 5),
                                    child: Expanded(
                                      child: GlassContainer(
                                        width: 130,
                                        blur: 4,
                                        child: TextFormField(
                                          style:
                                              TextStyle(color: Colors.white60),
                                          controller: fname,
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.purple
                                                  .withOpacity(0.3),
                                              errorText:
                                                  fnamevalid ? fnamee : null,
                                              hintText: "   First name",
                                              hintStyle: TextStyle(
                                                  color: Colors.white60,
                                                  fontSize: 15),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 10.0),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 15, bottom: 5, left: 5),
                                    child: Expanded(
                                      child: GlassContainer(
                                        width: 130,
                                        blur: 4,
                                        child: TextField(
                                          style:
                                              TextStyle(color: Colors.white60),
                                          controller: lname,
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.purple
                                                  .withOpacity(0.3),
                                              errorText:
                                                  lnamevalid ? lnamee : null,
                                              hintText: "   Last name",
                                              hintStyle: TextStyle(
                                                  color: Colors.white60,
                                                  fontSize: 15),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 10.0),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  padding: EdgeInsets.only(left: 15),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Gender",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black54),
                                  )),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Radio(
                                      value: "male",
                                      groupValue: gender,
                                      onChanged: (value) {
                                        setState(() {
                                          gender = value!;
                                        });
                                      },
                                    ),
                                    Text("Male"),
                                    Radio(
                                      value: "Female",
                                      groupValue: gender,
                                      onChanged: (value) {
                                        setState(() {
                                          gender = value!;
                                        });
                                      },
                                    ),
                                    Text("FeMale"),
                                    Radio(
                                      value: "Other",
                                      groupValue: gender,
                                      onChanged: (value) {
                                        setState(() {
                                          gender = value!;
                                        });
                                      },
                                    ),
                                    Text("Other")
                                  ]),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Date of Birth",
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 20)),
                                  GlassContainer(
                                    width: 150,
                                    color: Colors.purple.withOpacity(0.3),
                                    child: DateTimePicker(
                                      decoration: InputDecoration(
                                          hintText: "   select",
                                          hintStyle:
                                              TextStyle(color: Colors.white60),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none)),
                                      initialValue: '',
                                      style: TextStyle(color: Colors.white60),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                      dateLabelText: 'Date',
                                      onChanged: (val) => print(val),
                                      validator: (val) {
                                        print(val);
                                        return null;
                                      },
                                      onSaved: (val) => print(val),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "Swipe  to  Next",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 18, color: Colors.black54),
                                  ))
                            ]),
                          ),
                          height: 350,
                          color: Colors.white.withOpacity(0.2),
                          width: double.infinity,
                        ),
                      )),
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: GlassContainer(
                          child: SingleChildScrollView(
                            child: Column(children: [
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 12, left: 12, top: 7),
                                child: GlassContainer(
                                  blur: 4,
                                  child: TextField(
                                    style: TextStyle(color: Colors.white60),
                                    keyboardType: TextInputType.number,
                                    controller: ph,
                                    decoration: InputDecoration(
                                        errorText: invalid1 ? msg1 : null,
                                        filled: true,
                                        fillColor:
                                            Colors.purple.withOpacity(0.2),
                                        hintText: "   phone number",
                                        hintStyle: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 15),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 12, left: 12, top: 7),
                                child: GlassContainer(
                                  blur: 4,
                                  child: TextField(
                                    style: TextStyle(color: Colors.white60),
                                    controller: email,
                                    decoration: InputDecoration(
                                        errorText: invalid2 ? msg2 : null,
                                        filled: true,
                                        fillColor:
                                            Colors.purple.withOpacity(0.2),
                                        hintText: "   email",
                                        hintStyle: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 15),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 12, left: 12, top: 7),
                                child: GlassContainer(
                                  blur: 4,
                                  child: TextField(
                                    style: TextStyle(color: Colors.white60),
                                    controller: password,
                                    decoration: InputDecoration(
                                        errorText: invalid3 ? msg3 : null,
                                        filled: true,
                                        fillColor:
                                            Colors.purple.withOpacity(0.2),
                                        hintText: "   password",
                                        hintStyle: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 15),
                                        suffixIcon: Icon(Icons.remove_red_eye,
                                            color: Colors.white60),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () async {
                                  List<int> imagii =
                                      File(img).readAsBytesSync();
                                  String imagename = base64Encode(imagii);
                                  Map registerdataa = {
                                    "firstname": fname.text,
                                    "lastname": lname.text,
                                    "phonenum": ph.text,
                                    "emailadd": email.text,
                                    "passwords": password.text,
                                    "images": imagename,
                                  };
                                  var url = Uri.parse(
                                      'https://renilflutter.000webhostapp.com/ecomerce/rrrrr.php');
                                  var response =
                                      await http.post(url, body: registerdataa);
                                  print(
                                      'Response status: ${response.statusCode}');
                                  print('Response body: ${response.body}');
                                  print("==${registerdataa['firstname']}");

                                  var mm = jsonDecode(response.body);
                                  rr = apicall.fromJson(mm);

                                  if (rr!.connection == 1) {
                                    if (rr!.result == 1) {
                                      EasyLoading.show(status: "Please wait");
                                      Future.delayed(Duration(seconds: 2))
                                          .then((value) {
                                        EasyLoading.showSuccess(
                                            "Register successfully");
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return loginpage();
                                          },
                                        ));
                                      });
                                    } else if (rr!.result == 2) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text("User already exist")));
                                    }
                                  }

                                  // RegExp nameRegExp = RegExp('[a-zA-Z]');
                                  // RegExp numberRegExp =
                                  //     RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
                                  // RegExp usernameregex = RegExp(
                                  //     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                  // RegExp passregex = RegExp(
                                  //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

                                  fnamevalid = false;
                                  lnamevalid = false;
                                  invalid1 = false;
                                  invalid2 = false;
                                  invalid3 = false;

                                  setState(() async {
                                    if (fname.text.isEmpty) {
                                      fnamee = "enter fname";
                                      fnamevalid = true;
                                    } else if (lname.text.isEmpty) {
                                      lnamee = "enter lname";
                                      lnamevalid = true;
                                    }
                                    // else if (fnamevalid ||
                                    //     lnamevalid == false) {}
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 12, left: 12),
                                  child: GlassContainer(
                                    child: Center(
                                        child: Text(
                                      "Sign up",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.7)),
                                    )),
                                    blur: 5,
                                    height: 45,
                                    width: double.infinity,
                                    color: Colors.white.withOpacity(0.2),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Already a user?"),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return loginpage();
                                          },
                                        ));
                                      },
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color:
                                                Colors.purple.withOpacity(0.4)),
                                      ))
                                ],
                              )
                            ]),
                          ),
                          height: 350,
                          color: Colors.white.withOpacity(0.2),
                          width: double.infinity,
                        ),
                      )),
                    ],
                    controller: controller,
                  ))
            ]),
          ),
        ));
  }
}

class apicall {
  int? connection;
  int? result;

  apicall({this.connection, this.result});

  apicall.fromJson(Map<String, dynamic> json) {
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
