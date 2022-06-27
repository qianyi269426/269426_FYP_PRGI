import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:prgi/addinfo.dart';
import 'package:prgi/editinfo.dart';
import 'package:prgi/info.dart';
import 'package:prgi/user.dart';

class ManageScreen extends StatefulWidget {
  final User? user;
  const ManageScreen({Key? key, this.user}) : super(key: key);

  @override
  _ManageScreenState createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  List addinfolist = [];
  String _titlecenter = "Loading...";
  late double screenHeight;
  late double screenWidth;

  @override
  void initState() {
    super.initState();
    _loadInfo();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage GAE Units'),
        backgroundColor: const Color.fromRGBO(191, 30, 46, 50),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _add(context);
              }),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            if (addinfolist.isEmpty)
              Flexible(child: Center(child: Text(_titlecenter)))
            else
              Flexible(
                  child: OrientationBuilder(builder: (context, orientation) {
                return GridView.count(
                    crossAxisCount: 1,
                    childAspectRatio: (screenWidth / screenHeight) / 0.1,
                    children: List.generate(addinfolist.length, (index) {
                      return Card(
                        child: Row(
                          children: [
                            Expanded(
                                flex: 6,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        addinfolist[index]['code'],
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    color: Colors.grey[600],
                                    onPressed: () {
                                      _editinfo(index);
                                    },
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline_sharp),
                                    color: Colors.red,
                                    onPressed: () {
                                      _deleteDialog(index);
                                    },
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }));
              }))
          ],
        ),
      ),
    );
  }

  void _add(BuildContext context) {
    User user = User(email: widget.user!.email);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (content) => AddInfoScreen(
                  user: user,
                ))).then((value) => _loadInfo());
  }

  void _loadInfo() {
    String status = "a";

    http.post(
        Uri.parse("https://hubbuddies.com/s269426/prgi/php/load_info.php"),
        body: {
          "status": status,
          "email": widget.user!.email
        }).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "Sorry no data";
        return;
      } else {
        setState(() {
          var jsondata = json.decode(response.body);
          addinfolist = jsondata["addinfo"];

          print(addinfolist);
        });
      }
    });
    print(widget.user!.email);
  }

  void _deleteDialog(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text("Delete"),
            content: const Text("Are you sure to delete?"),
            actions: [
              TextButton(
                child: const Text('Ok', style: TextStyle(color: Colors.red)),
                onPressed: () {
                  Navigator.of(context).pop();
                  _delete(index);
                },
              ),
              TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  void _delete(int index) {
    http.post(
        Uri.parse("https://hubbuddies.com/s269426/prgi/php/delete_info.php"),
        body: {
          "email": widget.user!.email,
          "code": addinfolist[index]['code'],
          // "prprice": addresslist[index]['prprice'],
          // "quantity": qty.toString(),
        }).then((response) {
      print(response.body);

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
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        _loadInfo();
      }
    });
  }

  void _editinfo(int index) {
    Info info = Info(
      code: addinfolist[index]['code'],
      purchased_date: DateTime.parse(addinfolist[index]['purchased_date']),
      units: addinfolist[index]['units'],
      buy_price: addinfolist[index]['buy_price'],
      // manage_fee: addinfolist[index]['manage_fee'],
      manage_fee_refund: addinfolist[index]['manage_fee_refund'],
      nett: addinfolist[index]['nett'],
      target: addinfolist[index]['target'],
      type: addinfolist[index]['type'],
    );
    User user = User(email: widget.user!.email);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (content) => EditInfoScreen(
                  info: info,
                  user: user,
                ))).then((value) => _loadInfo());
  }
}
