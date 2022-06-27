import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:prgi/detailsscreen.dart';
import 'package:prgi/info.dart';
import 'package:prgi/user.dart';

class ReportScreen extends StatefulWidget {
  final Info? info;
  final User? user;
  const ReportScreen({Key? key, this.info, this.user}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List onhandlist = [];
  List soldlist = [];
  final String _titlecenter = "Loading...";
  late double screenHeight;
  late double screenWidth;
  bool _isVisible = false;
  bool _visible = false;
  double initial = 0, initial1 = 0;
  double profit = 0;
  double gross = 0;
  double nett = 0;
  double manageFeeRefund = 0;

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void showToast2() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  void initState() {
    super.initState();

    _loadOnhandInfo();
    loadSoldInfo();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Manage Report'),
          backgroundColor: const Color.fromRGBO(191, 30, 46, 50),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ExpansionTile(
                title: const Text('Units On Hand'),
                children: <Widget>[
                  Container(
                    height: screenHeight / 2,
                    child: ListView.builder(
                        itemCount: onhandlist.length,
                        itemBuilder: (context, index) {
                          return Container(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              width: screenWidth,
                              height: screenHeight / 14,
                              child: ListTile(
                                onTap: () {
                                  _onHandDetails(index);
                                },
                                title: Text(
                                  onhandlist[index]['code'],
                                  style: const TextStyle(fontSize: 18),
                                ),
                                trailing: MaterialButton(
                                    color: const Color.fromRGBO(191, 30, 46, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    onPressed: () {
                                      sold(onhandlist[index]['code']);
                                    },
                                    child: const Text(
                                      "Sold",
                                      style:
                                          TextStyle(color: Colors.white),
                                    )),
                              ));
                        }),
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text('Units Sold'),
                children: <Widget>[
                  Container(
                    height: screenHeight / 2,
                    child: ListView.builder(
                        itemCount: soldlist.length,
                        itemBuilder: (context, index) {
                          return Container(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              width: screenWidth,
                              height: screenHeight / 14,
                              child: ListTile(
                                onTap: () {
                                  _soldDetails(index);
                                },
                                title: Text(
                                  soldlist[index]['code'],
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ));
                        }),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  void _onHandDetails(int index) {
    Info info = Info(
      code: onhandlist[index]['code'],
      purchased_date: DateTime.parse(onhandlist[index]['purchased_date']),
      units: onhandlist[index]['units'],
      buy_price: onhandlist[index]['buy_price'],
      manage_fee: onhandlist[index]['management_fee'].toString(),
      manage_fee_refund: onhandlist[index]['manage_fee_refund'],
      nett: onhandlist[index]['nett'],
      target: onhandlist[index]['target'],
      type: onhandlist[index]['type'],
    );
    User user = User(email: widget.user!.email);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (content) => DetailsScreen(info: info, user: user)));
  }

  void _soldDetails(int index) {
    Info info = Info(
      code: soldlist[index]['code'],
      purchased_date: DateTime.parse(soldlist[index]['purchased_date']),
      units: soldlist[index]['units'],
      buy_price: soldlist[index]['buy_price'],
      manage_fee: soldlist[index]['management_fee'].toString(),
      manage_fee_refund: soldlist[index]['manage_fee_refund'],
      nett: soldlist[index]['nett'],
      target: soldlist[index]['target'],
      type: soldlist[index]['type'],
    );
    User user = User(email: widget.user!.email);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (content) => DetailsScreen(
                  info: info,
                  user: user,
                )));
  }

  void _loadOnhandInfo() {
    String status = "onhand";

    http.post(
        Uri.parse("https://hubbuddies.com/s269426/prgi/php/load_info.php"),
        body: {
          "status": status,
          "email": widget.user!.email
        }).then((response) {
      if (response.body == "nodata") {
        return;
      } else {
        setState(() {
          var jsondata = json.decode(response.body);
          onhandlist = jsondata["addinfo"];

          print(onhandlist);
          print(widget.user!.email);
        });
      }
    });
  }

  void loadSoldInfo() {
    String status = "sold";

    http.post(
        Uri.parse("https://hubbuddies.com/s269426/prgi/php/load_info.php"),
        body: {
          "status": status,
          "email": widget.user!.email
        }).then((response) {
      if (response.body == "nodata") {
        return;
      } else {
        setState(() {
          var jsondata = json.decode(response.body);
          soldlist = jsondata["addinfo"];
          print(soldlist);
          print(widget.user!.email);
        });
      }
    });
  }

  void sold(String code) {
    http.post(Uri.parse("https://hubbuddies.com/s269426/prgi/php/sold.php"),
        body: {
          "code": code,
          "email": widget.user!.email
        }).then((response) {
      if (response.body == "failed") {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Sold!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        _loadOnhandInfo();
        loadSoldInfo();
      }
    });
  }
}
