import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prgi/managescreen.dart';
import 'package:prgi/user.dart';

class AddInfoScreen extends StatefulWidget {
  final User? user;
  const AddInfoScreen({Key? key, this.user}) : super(key: key);

  @override
  _AddInfoScreenState createState() => _AddInfoScreenState();
}

class _AddInfoScreenState extends State<AddInfoScreen> {
  // List addinfolist = [];
  int gae = -1;
  DateTime date = DateTime.now();

  TextEditingController _code = new TextEditingController();
  TextEditingController _purchasedDate = new TextEditingController();
  TextEditingController _units = new TextEditingController();
  TextEditingController _buyPrice = new TextEditingController();
  // TextEditingController _manageFee = new TextEditingController();
  TextEditingController _manageFeeRefund = new TextEditingController();
  TextEditingController _nett = new TextEditingController();
  TextEditingController _target = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add GAE Units'),
        backgroundColor: const Color.fromRGBO(191, 30, 46, 50),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                shadowColor: Colors.red.shade900,
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Column(
                    children: [
                      TextField(
                        controller: _code,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Code',
                            icon: Icon(Icons.ad_units,
                                color: Colors.red.shade900)),
                      ),
                      // ListTile(
                      //   leading: Icon(Icons.date_range),
                      //   title: Text('${date.year}',
                      //         style: const TextStyle(fontSize: 20)),
                      //         trailing: ElevatedButton(
                      //     child: const Text('Date'),
                      //     onPressed: () async {
                      //       DateTime? newDate = await showDatePicker(
                      //           context: context,
                      //           initialDate: date,
                      //           firstDate: DateTime(1900),
                      //           lastDate: DateTime(2100));
                      //       if (newDate == null) return;

                      //       setState(() => date = newDate);
                      //     }),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Icon(Icons.date_range,
                                  color: Colors.red.shade900)),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                  '${date.year}/${date.month}/${date.day}',
                                  style: const TextStyle(fontSize: 18)),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: ElevatedButton(
                                child: const Text('PurchasedDate'),
                                onPressed: () async {
                                  DateTime? newDate = await showDatePicker(
                                      context: context,
                                      initialDate: date,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100));
                                  if (newDate == null) return;

                                  setState(() => date = newDate);
                                }),
                                
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // TextField(
                      //   controller: _purchasedDate,
                      //   keyboardType: TextInputType.datetime,
                      //   decoration: InputDecoration(
                      //       labelText: 'Purchased Date (yy/mm/dd)',
                      //       icon: Icon(Icons.date_range,
                      //           color: Colors.red.shade900)),
                      //   // obscureText: true,
                      // ),
                      TextField(
                        controller: _units,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Unit(s)',
                            icon: Icon(Icons.ac_unit,
                                color: Colors.red.shade900)),
                      ),
                      // TextField(
                      //   // controller: _passwordController,
                      //   keyboardType: TextInputType.number,
                      //   decoration: InputDecoration(
                      //       labelText: 'Quantity(g)',
                      //       icon: Icon(Icons.line_weight_outlined,
                      //           color: Colors.red.shade900)),
                      //   // obscureText: true,
                      // ),
                      TextField(
                        controller: _buyPrice,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Buy Price(USD)',
                            icon: Icon(Icons.attach_money_outlined,
                                color: Colors.red.shade900)),
                      ),

                      // TextField(
                      //   controller: _manageFee,
                      //   keyboardType: TextInputType.number,
                      //   decoration: InputDecoration(
                      //       labelText: 'Management Fee(USD): ',
                      //       icon: Icon(Icons.account_balance_wallet,
                      //           color: Colors.red.shade900)),
                      // ),
                      TextField(
                        controller: _manageFeeRefund,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Management Fee Refund(USD): ',
                            icon:
                                Icon(Icons.casino, color: Colors.red.shade900)),
                      ),
                      TextField(
                        controller: _nett,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Nett Cash Out (USD): ',
                            icon: Icon(Icons.currency_exchange_rounded,
                                color: Colors.red.shade900)),
                      ),
                      TextField(
                        controller: _target,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Target Percentage of Profit(%): ',
                            icon: Icon(Icons.bar_chart_outlined,
                                color: Colors.red.shade900)),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 5, 100, 10),
                        child: const Text("Type of GAE unit:",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.left),
                      ),
                      ListTile(
                        title: const Text("GAE 5X"),
                        leading: Radio(
                          value: 1,
                          groupValue: gae,
                          onChanged: (value) {
                            setState(() {
                              gae = int.parse(value.toString());
                            });
                          },
                          activeColor: Colors.red.shade900,
                        ),
                      ),
                      ListTile(
                        title: const Text("GAE 10X"),
                        leading: Radio(
                          value: 2,
                          groupValue: gae,
                          onChanged: (value) {
                            setState(() {
                              gae = int.parse(value.toString());
                            });
                          },
                          activeColor: Colors.red.shade900,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              _done();
                            },
                            child: Text("Submit",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.green[600])),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _done() {
    String code = _code.text.toString();
    int purchasedYear;
    int purchasedMonth;
    String purchasedDate = date.year.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.day.toString();
    String units = _units.text.toString();
    String buyPrice = _buyPrice.text.toString();
    // String manageFee = _manageFee.text.toString();
    String manageFeeRefund = _manageFeeRefund.text.toString();
    String nett = _nett.text.toString();
    String target = _target.text.toString();
    String type = "a";

    print(gae);
    if (gae == 1) {
      type = "GAE 5X";
    } else if (gae == 2) {
      type = "GAE 10X";
    }

    http.post(Uri.parse("https://hubbuddies.com/s269426/prgi/php/add_info.php"),
        body: {
          "email": widget.user!.email,
          "code": code,
          "purchased_date": purchasedDate,
          "units": units,
          "buy_price": buyPrice,
          // "manage_fee": manageFee,
          "manage_fee_refund": manageFeeRefund,
          "nett": nett,
          "target": target,
          "type": type,
        }).then((response) {
      print(response.body);

      if (response.body == "Success") {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }else if (response.body == "Duplicate") {
        Fluttertoast.showToast(
            msg: "Duplicate Insert!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }else {
        Fluttertoast.showToast(
            msg: "Failed!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        // _loadInfo();
      }
    });
    User user = User(email: widget.user!.email);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (content) => ManageScreen(user: user,
                // user: widget.user,
                )));
  }
  
}
