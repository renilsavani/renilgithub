import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingapp/api%20project/home%20page.dart';
import 'package:shoppingapp/api%20project/signuppage.dart';
import 'package:http/http.dart' as http;

class loginpage extends StatefulWidget {
  static SharedPreferences? prefs;

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool check = false;
  apilogin? aa;
  bool sp = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ddd();
  }

  Future<void> ddd() async {
    loginpage.prefs = await SharedPreferences.getInstance();
    setState(() {
      sp = loginpage.prefs!.getBool("cnt") ?? false;
    });
    if (sp) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return homepage();
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/loginbg.jpg"), fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(children: [
              Center(
                child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.1),
                    height: 200,
                    width: 200,
                    child: RiveAnimation.asset(
                        "riveee/animated_login_character.riv")),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: GlassContainer(
                  child: Column(children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text("Login",
                        style: GoogleFonts.nobile(
                            fontSize: 30, color: Colors.white60)),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 12, left: 12, bottom: 5),
                      child: GlassContainer(
                        blur: 4,
                        color: Colors.pink.withOpacity(0.2),
                        child: TextField(
                          controller: email,
                          decoration: InputDecoration(
                              hintText: "   email",
                              hintStyle: TextStyle(
                                  color: Colors.white60, fontSize: 15),
                              suffixIcon: Icon(Icons.email_outlined,
                                  color: Colors.white60),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10.0),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 12, left: 12, top: 7),
                      child: GlassContainer(
                        blur: 4,
                        color: Colors.pink.withOpacity(0.2),
                        child: TextField(
                          controller: password,
                          decoration: InputDecoration(
                              hintText: "   password",
                              hintStyle: TextStyle(
                                  color: Colors.white60, fontSize: 15),
                              suffixIcon: Icon(Icons.remove_red_eye,
                                  color: Colors.white60),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10.0),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: check,
                          onChanged: (value) {
                            setState(() {
                              check = true;
                            });
                          },
                        ),
                        Text(
                          "Remember me",
                          style: TextStyle(color: Colors.white60),
                        )
                      ],
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    InkWell(
                      onTap: () async {
                        Map map = {
                          "email": email.text,
                          "password": password.text
                        };
                        var url = Uri.parse(
                            'https://renilflutter.000webhostapp.com/ecomerce/login.php');
                        var response = await http.post(url, body: map);
                        print('Response status: ${response.statusCode}');
                        print('Response body: ${response.body}');
                        var rr = jsonDecode(response.body);
                        aa = apilogin.fromJson(rr);

                        if (aa!.connection == 1) {
                          if (aa!.result == 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("user not found")));
                          } else if (aa!.result == 1) {
                            loginpage.prefs!.setBool("cnt", true);

                            loginpage.prefs!
                                .setString("fname", "${aa!.userdata!.fNAME}");
                            loginpage.prefs!
                                .setString("lname", "${aa!.userdata!.lNAME}");
                            loginpage.prefs!
                                .setString("image", "${aa!.userdata!.iMAGE}");
                            loginpage.prefs!
                                .setString("email", "${aa!.userdata!.eMAIL}");
                            loginpage.prefs!
                                .setString("userid", "${aa!.userdata!.iD}");
                            EasyLoading.show(status: "Please wait");
                            Future.delayed(Duration(seconds: 2)).then((value) {
                              EasyLoading.showSuccess("Login successfully");
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return homepage();
                                },
                              ));
                            });
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12, left: 12),
                        child: GlassContainer(
                          child: Center(child: Text("Login")),
                          blur: 5,
                          height: 45,
                          width: double.infinity,
                          color: Colors.white.withOpacity(0.4),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Don't Have An Account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return signuppage();
                                },
                              ));
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.pink.withOpacity(0.4)),
                            ))
                      ],
                    )
                  ]),
                  blur: 5,
                  height: 350,
                  width: double.infinity,
                  color: Colors.white.withOpacity(0.2),
                ),
              )
            ]),
          ),
        ));
  }
}

class apilogin {
  int? connection;
  int? result;
  Userdata? userdata;

  apilogin({this.connection, this.result, this.userdata});

  apilogin.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    userdata = json['userdata'] != null
        ? new Userdata.fromJson(json['userdata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.userdata != null) {
      data['userdata'] = this.userdata!.toJson();
    }
    return data;
  }
}

class Userdata {
  String? iD;
  String? fNAME;
  String? lNAME;
  String? pHNUM;
  String? eMAIL;
  String? pASSWORD;
  String? iMAGE;

  Userdata(
      {this.iD,
      this.fNAME,
      this.lNAME,
      this.pHNUM,
      this.eMAIL,
      this.pASSWORD,
      this.iMAGE});

  Userdata.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    fNAME = json['FNAME'];
    lNAME = json['LNAME'];
    pHNUM = json['PHNUM'];
    eMAIL = json['EMAIL'];
    pASSWORD = json['PASSWORD'];
    iMAGE = json['IMAGE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['FNAME'] = this.fNAME;
    data['LNAME'] = this.lNAME;
    data['PHNUM'] = this.pHNUM;
    data['EMAIL'] = this.eMAIL;
    data['PASSWORD'] = this.pASSWORD;
    data['IMAGE'] = this.iMAGE;
    return data;
  }
}
