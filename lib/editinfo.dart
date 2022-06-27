import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:prgi/info.dart';
import 'package:prgi/user.dart';

class EditInfoScreen extends StatefulWidget {
  final User? user;
  final Info? info;
  const EditInfoScreen({Key? key, this.info, this.user}) : super(key: key);

  @override
  _EditInfoScreenState createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends State<EditInfoScreen> {
  List addinfolist = [];
  int gae = -1;
  bool _isEnable = false;
  String purchased_date = "a";

  TextEditingController _units = new TextEditingController();
  TextEditingController _buyPrice = new TextEditingController();
  TextEditingController _manageFee = new TextEditingController();
  TextEditingController _manageFeeRefund = new TextEditingController();
  TextEditingController _nett = new TextEditingController();
  TextEditingController _target = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _units.text = widget.info!.units!;
    _buyPrice.text = widget.info!.buy_price!;
    // _manageFee.text = widget.info!.manage_fee!;
    _manageFeeRefund.text = widget.info!.manage_fee_refund!;
    _nett.text = widget.info!.nett!;
    _target.text = widget.info!.target!;

    _loadInfo();
  }

  @override
  Widget build(BuildContext context) {
    purchased_date =
        DateFormat("yyyy-MM-dd").format(widget.info!.purchased_date!);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit GAE Units'),
        backgroundColor: const Color.fromRGBO(191, 30, 46, 50),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            Card(
              shadowColor: Colors.red.shade900,
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(Icons.phone_android_sharp,
                                      color: Colors.red.shade900),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            'Code: ' + widget.info!.code!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(Icons.date_range,
                                      color: Colors.red.shade900),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            'Purchased Date (yy/mm/dd): ' + purchased_date,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: 50,
                              child: TextField(
                                controller: _units,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: 'Unit(s)',
                                    enabled: _isEnable,
                                    icon: Icon(Icons.ac_unit,
                                        color: Colors.red.shade900)),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: IconButton(
                                  alignment: Alignment.topRight,
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    setState(() {
                                      _isEnable = true;
                                    });
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: TextField(
                                controller: _buyPrice,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: 'Buy Price(USD)',
                                    enabled: _isEnable,
                                    icon: Icon(Icons.attach_money_outlined,
                                        color: Colors.red.shade900)),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: IconButton(
                                  alignment: Alignment.topRight,
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    setState(() {
                                      _isEnable = true;
                                    });
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: TextField(
                                controller: _manageFee,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: 'Management Fee: ',
                                    enabled: _isEnable,
                                    icon: Icon(Icons.account_balance_wallet,
                                        color: Colors.red.shade900)),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: IconButton(
                                  alignment: Alignment.topRight,
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    setState(() {
                                      _isEnable = true;
                                    });
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: TextField(
                                controller: _manageFeeRefund,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: 'Management Fee Refund (USD): ',
                                    enabled: _isEnable,
                                    icon: Icon(Icons.account_balance_wallet,
                                        color: Colors.red.shade900)),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: IconButton(
                                  alignment: Alignment.topRight,
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    setState(() {
                                      _isEnable = true;
                                    });
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: TextField(
                                controller: _nett,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: 'Nett Cash Out (USD): ',
                                    enabled: _isEnable,
                                    icon: Icon(Icons.account_balance_wallet,
                                        color: Colors.red.shade900)),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: IconButton(
                                  alignment: Alignment.topRight,
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    setState(() {
                                      _isEnable = true;
                                    });
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: TextField(
                                controller: _target,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: 'Target Percentage of Profit: ',
                                    enabled: _isEnable,
                                    icon: Icon(Icons.bar_chart_outlined,
                                        color: Colors.red.shade900)),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: IconButton(
                                  alignment: Alignment.topRight,
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    setState(() {
                                      _isEnable = true;
                                    });
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Text(
                            'Type of GAE units: ' + widget.info!.type!,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            _update();
                          },
                          child: Text("UPDATE",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.green[600])),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  void _loadInfo() {
    http.post(
        Uri.parse("https://hubbuddies.com/s269426/prgi/php/load_info.php"),
        body: {"email": widget.user!.email}).then((response) {
      if (response.body == "nodata") {
        return;
      } else {
        setState(() {
          var jsondata = json.decode(response.body);
          addinfolist = jsondata["addinfo"];
          print(addinfolist);
          print(widget.user!.email);
        });
      }
    });
  }

  void _update() {
    String units = _units.text.toString();
    String buy_price = _buyPrice.text.toString();
    String manage_fee = _manageFee.text.toString();
    String manage_fee_refund = _manageFeeRefund.text.toString();
    String nett = _nett.text.toString();
    String target = _target.text.toString();

    print(units);
    print(buy_price);
    http.post(
        Uri.parse("https://hubbuddies.com/s269426/prgi/php/update_info.php"),
        body: {
          "email": widget.user!.email,
          "code": widget.info!.code,
          "units": units,
          "buy_price": buy_price,
          "manage_fee": manage_fee,
          "manage_fee_refund": manage_fee_refund,
          "nett": nett,
          "target": target,
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
            msg: "Updated!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {
          widget.info!.units = _units.text.toString();
          widget.info!.buy_price = _buyPrice.text.toString();
          widget.info!.manage_fee = _manageFee.text.toString();
          widget.info!.manage_fee_refund = _manageFeeRefund.text.toString();
          widget.info!.nett = _nett.text.toString();
          widget.info!.target = _target.text.toString();
        });
      }
    });
  }
}
