import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shoppingapp/api%20project/addproduct.dart';
import 'package:shoppingapp/api%20project/loginpage.dart';
import 'package:shoppingapp/api%20project/update%20product.dart';
import 'package:shoppingapp/api%20project/viewdetailsproduct.dart';

class homepage extends StatefulWidget {
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int a = 0;
  List<Widget> ll = [viewproduct(), cart(), profile()];
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              actions: [
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                          child: Text(
                        "Are you sure you want to Exit?",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.orangeAccent),
                            child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    SystemNavigator.pop();
                                  });
                                },
                                child: Text(
                                  "yes",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                )),
                          ),
                          Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.orangeAccent),
                            child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                },
                                child: Text(
                                  "no",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            );
          },
        );
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: AdvancedDrawer(
        backdropColor: Colors.orange.shade300,
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: false,
        // openScale: 1.0,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        drawer: SafeArea(
          child: Container(
            child: ListTileTheme(
              textColor: Colors.white,
              iconColor: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                      width: 128.0,
                      height: 128.0,
                      margin: const EdgeInsets.only(
                        top: 24.0,
                        bottom: 24.0,
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://renilflutter.000webhostapp.com/ecomerce/${loginpage.prefs!.getString("image") ?? ""}"),
                      )),
                  Text("${loginpage.prefs!.getString("email") ?? ""}",
                      style: TextStyle(fontSize: 17, color: Colors.black54)),
                  SizedBox(height: 30),
                  Divider(height: 2, thickness: 2),
                  ListTile(
                    onTap: () {
                      EasyLoading.show(status: "Please wait");
                      Future.delayed(Duration(seconds: 1)).then((value) {
                        EasyLoading.dismiss(animation: false);
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return homepage();
                          },
                        ));
                      });
                    },
                    leading: Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                    title: Text('Home', style: TextStyle(color: Colors.black)),
                  ),
                  ListTile(
                    onTap: () {
                      EasyLoading.show(status: "Please wait");
                      Future.delayed(Duration(seconds: 2)).then((value) {
                        EasyLoading.dismiss(animation: false);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return addproduct();
                          },
                        ));
                      });
                    },
                    leading: Icon(Icons.add, color: Colors.black),
                    title: Text('addproduct',
                        style: TextStyle(color: Colors.black)),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.settings, color: Colors.black),
                    title:
                        Text('Settings', style: TextStyle(color: Colors.black)),
                  ),
                  Divider(thickness: 2),
                  ListTile(
                    onTap: () {
                      loginpage.prefs!.setBool("cnt", false);
                      EasyLoading.show(status: "Please wait");
                      Future.delayed(Duration(seconds: 2)).then((value) {
                        EasyLoading.showSuccess("Logout successfull");
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return loginpage();
                          },
                        ));
                      });
                    },
                    leading: Icon(Icons.logout, color: Colors.black),
                    title:
                        Text('Log out', style: TextStyle(color: Colors.black)),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
        child: Scaffold(
          body: ll[a],
          bottomNavigationBar: GlassContainer(
              // shadowStrength: 6,
              blur: 4,
              shadowStrength: 5,
              shadowColor: Colors.black.withOpacity(0.24),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.indigoAccent.withOpacity(0.6),
                  Colors.blue.withOpacity(0.5),
                ],
              ),
              color: Colors.indigo,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25), topLeft: Radius.circular(25)),
              // color: Colors.indigo,
              // blur: 20,
              height: 56,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          a = 0;
                        });
                      },
                      icon: Icon(
                        Icons.home,
                        size: 33,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          a = 1;
                        });
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        size: 33,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          a = 2;
                        });
                      },
                      icon: Icon(
                        Icons.person,
                        size: 33,
                        color: Colors.white,
                      )),
                ],
              )),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 5,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.indigoAccent.withOpacity(0.6),
                    Colors.blue.withOpacity(0.5),
                  ],
                ),
              ),
            ),

            // backgroundColor: Colors.indigo,
            title: const Text('Ecommerce App'),
            actions: [
              InkWell(
                onTap: () {
                  setState(() {
                    a = 1;
                  });
                },
                child: Container(
                  padding: EdgeInsets.only(right: 13, top: 10),
                  child: badges.Badge(
                    badgeContent: Text('1'),
                    child: Icon(Icons.shopping_cart, size: 30),
                  ),
                ),
              )
            ],
            leading: IconButton(
              onPressed: _handleMenuButtonPressed,
              icon: ValueListenableBuilder<AdvancedDrawerValue>(
                valueListenable: _advancedDrawerController,
                builder: (_, value, __) {
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 950),
                    child: Icon(
                      value.visible ? Icons.clear : Icons.menu,
                      key: ValueKey<bool>(value.visible),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}

class viewproduct extends StatefulWidget {
  const viewproduct({Key? key}) : super(key: key);

  @override
  State<viewproduct> createState() => _viewproductState();
}

class _viewproductState extends State<viewproduct> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data();
  }

  ff? aa2;
  ddd? dd;
  bool loder = false;
  List name = [
    'car & bike',
    'home & kitchen',
    'Electronics',
    'Jwellery',
    'Books',
    'Toys & games'
  ];
  List image = [
    "https://images.unsplash.com/photo-1605559424843-9e4c228bf1c2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bWVyY2VkZXMlMjBjYXJ8ZW58MHx8MHx8&w=1000&q=80",
    "https://i.insider.com/5ee799f619182412d631a997?width=1136&format=jpeg",
    "https://media.istockphoto.com/id/166107706/photo/mobility-concept-with-digital-devices-on-laptop.jpg?s=612x612&w=0&k=20&c=cjnkfi3c8hjHq76VV0KI1pNDgnyuyHZOE1l8-o0_QY8=",
    "https://cdn.shopify.com/s/files/1/1911/0603/products/SemiBridalTempleJewellery_1_1000x.jpg?v=1629635608",
    "https://images.theconversation.com/files/45159/original/rptgtpxd-1396254731.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=754&fit=clip",
    "https://www.toyfun.in/wp-content/uploads/2023/02/Building-Blocks.jpg",
  ];

  data() async {
    String id = loginpage.prefs!.getString("userid") ?? "";
    Map m = {"ID": id};
    var url = Uri.parse(
        'https://renilflutter.000webhostapp.com/ecomerce/viewproduct.php');
    var response = await http.post(url, body: m);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var mm = jsonDecode(response.body);
    setState(() {
      dd = ddd.fromJson(mm);
      loder = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: loder
            ? RefreshIndicator(
                color: Colors.deepOrange,
                onRefresh: () {
                  return Future.delayed(Duration(seconds: 1)).then((value) {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return homepage();
                      },
                    ));
                  });
                },
                child: SingleChildScrollView(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 5,
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.orange.withOpacity(0.6),
                                  Colors.deepOrange.withOpacity(0.5),
                                ],
                              ),
                            ),
                            child: TextField(
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.search),
                                  hintText: "  search product",
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10.0),
                                  // filled: true,
                                  // fillColor: Colors.orange.shade400,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text("Categories",
                            style: GoogleFonts.adventPro(
                                color: Colors.black54,
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 100,
                      width: double.infinity,
                      child: AnimationLimiter(
                        child: ListView.builder(
                          itemCount: 6,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredList(
                              position: 6,
                              duration: Duration(milliseconds: 375),
                              child: FadeInAnimation(
                                duration: Duration(milliseconds: 200),
                                delay: Duration(milliseconds: 200),
                                child: Container(
                                  decoration: BoxDecoration(

                                      // border: Border.all(),
                                      image: DecorationImage(
                                          image:
                                              NetworkImage("${image[index]}"),
                                          fit: BoxFit.fill),
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.all(10),
                                  height: 80,
                                  width: 80,
                                  child: Center(
                                    child: Text('${name[index]}',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.white)),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text("Products",
                            style: GoogleFonts.adventPro(
                                color: Colors.black54,
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        height: 400,
                        width: double.infinity,
                        child: AnimationLimiter(
                          child: GridView.builder(
                            itemCount: dd!.productdata!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.8, crossAxisCount: 2),
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredGrid(
                                position: dd!.productdata!.length,
                                duration: const Duration(milliseconds: 375),
                                delay: Duration(seconds: 1),
                                columnCount: dd!.productdata!.length,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FadeInAnimation(
                                    child: ScaleAnimation(
                                      // delay: Duration(milliseconds: 200),
                                      child: InkWell(
                                        onLongPress: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                backgroundColor:
                                                    Colors.transparent,
                                                actions: [
                                                  Center(
                                                    child: Container(
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                                        return updateproduct(
                                                                            dd!.productdata![index]);
                                                                      },
                                                                    ));
                                                                  },
                                                                  child: Text(
                                                                    "update",
                                                                    style: TextStyle(
                                                                        decoration:
                                                                            TextDecoration
                                                                                .underline,
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            17),
                                                                  )),
                                                              TextButton(
                                                                  onPressed:
                                                                      () async {
                                                                    // Navigator.pop(context);
                                                                    String aa =
                                                                        "${dd!.productdata![index].iD}";
                                                                    Map mm = {
                                                                      "IDD": aa
                                                                    };
                                                                    var url = Uri
                                                                        .parse(
                                                                            'https://renilflutter.000webhostapp.com/ecomerce/delete.php');
                                                                    var response =
                                                                        await http.post(
                                                                            url,
                                                                            body:
                                                                                mm);
                                                                    print(
                                                                        'Response status: ${response.statusCode}');
                                                                    print(
                                                                        'Response body: ${response.body}');
                                                                    var aa1 = jsonDecode(
                                                                        response
                                                                            .body);
                                                                    aa2 = ff
                                                                        .fromJson(
                                                                            aa1);

                                                                    if (aa2!.connection ==
                                                                        1) {
                                                                      if (aa2!.result ==
                                                                          1) {
                                                                        EasyLoading.show(
                                                                            status:
                                                                                "Please wait");
                                                                        Future.delayed(Duration(seconds: 2))
                                                                            .then((value) {
                                                                          EasyLoading.dismiss(
                                                                              animation: false);
                                                                          Navigator.pushReplacement(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                            builder:
                                                                                (context) {
                                                                              return homepage();
                                                                            },
                                                                          ));
                                                                        });
                                                                      }
                                                                    }
                                                                  },
                                                                  child: Text(
                                                                    "delete",
                                                                    style: TextStyle(
                                                                        decoration:
                                                                            TextDecoration
                                                                                .underline,
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            17),
                                                                  ))
                                                            ]),
                                                        decoration:
                                                            BoxDecoration(
                                                                gradient:
                                                                    LinearGradient(
                                                                  begin: Alignment
                                                                      .topLeft,
                                                                  end: Alignment
                                                                      .bottomRight,
                                                                  colors: [
                                                                    Colors
                                                                        .orange
                                                                        .withOpacity(
                                                                            0.6),
                                                                    Colors
                                                                        .deepOrange
                                                                        .withOpacity(
                                                                            0.5),
                                                                  ],
                                                                ),
                                                                // color: Colors.orange.shade300,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                        height: 70,
                                                        width: 200),
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: viewdetails(
                                                    dd!.productdata![index]),
                                                inheritTheme: true,
                                                ctx: context),
                                          );
                                        },
                                        child: Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: GlassContainer(
                                              blur: 4,
                                              opacity: 0.2,
                                              gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  Colors.orange
                                                      .withOpacity(0.6),
                                                  Colors.deepOrange
                                                      .withOpacity(0.5),
                                                ],
                                              ),
                                              color: Colors.orangeAccent,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    height: 125,
                                                    width: 112,
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          begin:
                                                              Alignment.topLeft,
                                                          end: Alignment
                                                              .bottomRight,
                                                          colors: [
                                                            Colors.orange
                                                                .withOpacity(
                                                                    0.6),
                                                            Colors.deepOrange
                                                                .withOpacity(
                                                                    0.5),
                                                          ],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                "https://renilflutter.000webhostapp.com/ecomerce/${dd!.productdata![index].iMAGE}"),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                      "${dd!.productdata![index].nAME}",
                                                      style: GoogleFonts.asap(
                                                          fontSize: 18)),
                                                  SizedBox(
                                                    height: 7,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        "₹${dd!.productdata![index].mRP}",
                                                        style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough),
                                                      ),
                                                      Text(
                                                        "₹${dd!.productdata![index].pRICE}",
                                                        style: TextStyle(),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ))
                  ]),
                ),
              )
            : Center(
                child: Container(
                    color: Colors.transparent,
                    height: 80,
                    width: 80,
                    child: Lottie.asset(
                        "lottiee/97952-loading-animation-blue.json"))));
  }
}

class ff {
  int? connection;
  int? result;

  ff({this.connection, this.result});

  ff.fromJson(Map<String, dynamic> json) {
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

class ddd {
  int? connection;
  int? result;

  List<Productdata>? productdata;

  ddd({this.connection, this.result, this.productdata});

  ddd.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    if (json['productdata'] != null) {
      productdata = <Productdata>[];
      json['productdata'].forEach((v) {
        productdata!.add(new Productdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.productdata != null) {
      data['productdata'] = this.productdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Productdata {
  String? iD;
  String? uSERID;
  String? cAT;
  String? nAME;
  String? bNAME;
  String? pRICE;
  String? mRP;
  String? qUE;
  String? wARRENTY;
  String? iMAGE;
  String? dISCRIPTION;

  Productdata(
      {this.iD,
      this.uSERID,
      this.cAT,
      this.nAME,
      this.bNAME,
      this.pRICE,
      this.mRP,
      this.qUE,
      this.wARRENTY,
      this.iMAGE,
      this.dISCRIPTION});

  Productdata.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    uSERID = json['USERID'];
    cAT = json['CAT'];
    nAME = json['NAME'];
    bNAME = json['BNAME'];
    pRICE = json['PRICE'];
    mRP = json['MRP'];
    qUE = json['QUE'];
    wARRENTY = json['WARRENTY'];
    iMAGE = json['IMAGE'];
    dISCRIPTION = json['DISCRIPTION'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['USERID'] = this.uSERID;
    data['CAT'] = this.cAT;
    data['NAME'] = this.nAME;
    data['BNAME'] = this.bNAME;
    data['PRICE'] = this.pRICE;
    data['MRP'] = this.mRP;
    data['QUE'] = this.qUE;
    data['WARRENTY'] = this.wARRENTY;
    data['IMAGE'] = this.iMAGE;
    data['DISCRIPTION'] = this.dISCRIPTION;
    return data;
  }
}

class cart extends StatefulWidget {
  const cart({Key? key}) : super(key: key);

  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("No more Items in cart")),
    );
  }
}

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  Color baseColor = Color(0xFFF2F2F2);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.orange.withOpacity(0.6),
                Colors.deepOrange.withOpacity(0.5),
              ],
            ),
          ),
          child: Column(children: [
            SizedBox(
              height: 200,
            ),
            Card(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.orange.withOpacity(0.6),
                      Colors.deepOrange.withOpacity(0.5),
                    ],
                  ),
                ),
                child: ListTile(
                  onTap: () {},
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                  leading:
                      Icon(Icons.privacy_tip_outlined, color: Colors.white),
                  title: Text("Privacy", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            Card(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.orange.withOpacity(0.6),
                      Colors.deepOrange.withOpacity(0.5),
                    ],
                  ),
                ),
                child: ListTile(
                  onTap: () {},
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                  leading: Icon(Icons.help, color: Colors.white),
                  title: Text("Help & Support",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            Card(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.orange.withOpacity(0.6),
                      Colors.deepOrange.withOpacity(0.5),
                    ],
                  ),
                ),
                child: ListTile(
                  onTap: () {},
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                  leading: Icon(Icons.settings, color: Colors.white),
                  title: Text("Setting", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            Card(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.orange.withOpacity(0.6),
                      Colors.deepOrange.withOpacity(0.5),
                    ],
                  ),
                ),
                child: ListTile(
                  onTap: () {},
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                  leading: Icon(Icons.person_add, color: Colors.white),
                  title: Text("Invite a Friend",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            Card(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.orange.withOpacity(0.6),
                      Colors.deepOrange.withOpacity(0.5),
                    ],
                  ),
                ),
                child: ListTile(
                  onTap: () {
                    loginpage.prefs!.setBool("cnt", false);
                    EasyLoading.show(status: "Please wait");
                    Future.delayed(Duration(seconds: 2)).then((value) {
                      EasyLoading.showSuccess("Logout successfull");
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return loginpage();
                        },
                      ));
                    });
                  },
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                  leading: Icon(Icons.logout, color: Colors.white),
                  title: Text("Log out", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ]),
          // color: Colors.orange,
        ),
        Container(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                  "${loginpage.prefs!.getString("fname") ?? ""}  ${loginpage.prefs!.getString("lname") ?? ""}",
                  style: TextStyle(fontSize: 15, color: Colors.black54)),
              Text("${loginpage.prefs!.getString("email") ?? ""}",
                  style: TextStyle(fontSize: 15, color: Colors.black54)),
            ],
          ),
          // child: Positioned(
          //   child: Text(
          //       "${loginpage.prefs!.getString("fname") ?? ""} ${loginpage.prefs!.getString("lname") ?? ""}"),
          // ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          height: 140,
          width: double.infinity,
        ),
        Positioned(
            top: 60,
            left: 100,
            right: 100,
            child: CircleAvatar(
              // foregroundColor: Colors.grey,
              backgroundImage: NetworkImage(
                  "https://renilflutter.000webhostapp.com/ecomerce/${loginpage.prefs!.getString("image") ?? ""}"),
              radius: 60,
            ))
      ]),
    );
  }
}
