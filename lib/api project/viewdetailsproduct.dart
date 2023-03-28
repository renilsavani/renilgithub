import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shoppingapp/api%20project/home%20page.dart';
import 'package:http/http.dart' as http;
import 'package:shoppingapp/api%20project/loginpage.dart';

class viewdetails extends StatefulWidget {
  Productdata productdata;

  viewdetails(Productdata this.productdata);

  @override
  State<viewdetails> createState() => _viewdetailsState();
}

class _viewdetailsState extends State<viewdetails> {
  ff? aa2;
  Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("$response")));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("$response")));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("$response")));
  }

  ddd? dd;

  data() async {
    String id = loginpage.prefs!.getString("userid") ?? "";
    Map m = {"ID": id};
    var url = Uri.parse(
        'https://renilflutter.000webhostapp.com/ecomerce/viewmultiimage.php');
    var response = await http.post(url, body: m);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var mm = jsonDecode(response.body);
    setState(() {
      dd = ddd.fromJson(mm);
    });
  }

  double curent = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        child: Row(children: [
          Expanded(
              child: InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.orange.withOpacity(0.6),
                    Colors.deepOrange.withOpacity(0.5),
                  ],
                ),
              ),
              height: double.infinity,
              child: Center(
                  child: Text("Add To Cart",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold))),
            ),
          )),
          Expanded(
              child: InkWell(
            onTap: () {
              var options = {
                'key': 'rzp_test_WRmb2eQyO3F0DX',
                'amount': 10000,
                'name': 'Acme Corp.',
                'description': 'Fine T-Shirt',
                'prefill': {
                  'contact': '7622944569',
                  'email': 'test@razorpay.com'
                }
              };
              _razorpay.open(options);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(25)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.indigoAccent.withOpacity(0.6),
                    Colors.blue.withOpacity(0.5),
                  ],
                ),
              ),
              height: double.infinity,
              child: Center(
                  child: Text("Buy Product",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
            ),
          ))
        ]),
        height: 60,
      ),
      appBar: AppBar(
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
          backgroundColor: Colors.transparent,
          actions: [
            PopupMenuButton<int>(
              itemBuilder: (context) => [
                // popupmenu item 1
                PopupMenuItem(
                  onTap: () async {
                    String aa = "${widget.productdata!.iD}";
                    Map mm = {"IDD": aa};
                    var url = Uri.parse(
                        'https://renilflutter.000webhostapp.com/ecomerce/delete.php');
                    var response = await http.post(url, body: mm);
                    print('Response status: ${response.statusCode}');
                    print('Response body: ${response.body}');
                    var aa1 = jsonDecode(response.body);
                    aa2 = ff.fromJson(aa1);

                    if (aa2!.connection == 1) {
                      if (aa2!.result == 1) {
                        EasyLoading.show(status: "Please wait");
                        Future.delayed(Duration(seconds: 1)).then((value) {
                          EasyLoading.dismiss(animation: false);
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return homepage();
                            },
                          ));
                        });
                      }
                    }
                  },
                  value: 1,
                  // row has two child icon and text.
                  child: Row(
                    children: [
                      Icon(Icons.delete),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "delete product",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                // popupmenu item 2
                PopupMenuItem(
                  onTap: () {},
                  value: 2,
                  // row has two child icon and text
                  child: Row(
                    children: [
                      Icon(Icons.update),
                      SizedBox(
                        // sized box with width 10
                        width: 10,
                      ),
                      Text("update ptoduct",
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ],
              offset: Offset(0, 100),
              color: Colors.orangeAccent,
              elevation: 2,
            ),
          ],
          title: Text("${widget.productdata.cAT}")),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "${widget.productdata.nAME}",
                  style: TextStyle(fontSize: 18),
                )),
          ),
          SizedBox(
            height: 30,
          ),

          CarouselSlider.builder(
              itemCount: widget.productdata.iMAGE!.length,
              itemBuilder: (context, index, realIndex) {
                return PhotoView(
                    imageProvider:
                        NetworkImage("${widget.productdata.iMAGE![index]}"));
              },
              options: CarouselOptions(
                  enableInfiniteScroll: false,
                  initialPage: 0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      print("====$index");
                      curent = double.parse("$index");
                    });
                  },
                  // height: 300,
                  enlargeCenterPage: true,
                  viewportFraction: 0.8)),
          // Center(
          //   child: Container(
          //       height: 300,
          //       width: 300,
          //       decoration: BoxDecoration(
          //           image: DecorationImage(
          //               image: NetworkImage(
          //                   "https://renilflutter.000webhostapp.com/ecomerce/${widget.productdata.iMAGE}"),
          //               fit: BoxFit.cover))),
          // ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text("₹"),
                    Text(
                      "${widget.productdata.pRICE}",
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text("M.R.P : ₹"),
                    Text(
                      "${widget.productdata.mRP}",
                      style: TextStyle(
                          fontSize: 15, decoration: TextDecoration.lineThrough),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Details",
                  style: GoogleFonts.alike(fontSize: 22),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text("Brand                ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      "${widget.productdata.bNAME}",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text("Category          ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      "${widget.productdata.cAT}",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text("Stock                ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      "${widget.productdata.qUE}",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text("Warrenty          ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      "${widget.productdata.wARRENTY}",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Discription",
                  style: GoogleFonts.alike(fontSize: 22),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  maxLines: 20,
                  "${widget.productdata.dISCRIPTION}",
                )),
          ),
          SizedBox(
            height: 20,
          )
        ]),
      ),
    );
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
