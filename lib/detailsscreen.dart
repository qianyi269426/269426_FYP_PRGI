import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prgi/info.dart';
import 'package:prgi/user.dart';

class DetailsScreen extends StatefulWidget {
  final Info? info;
  final User? user;
  final double? profit;
  const DetailsScreen({Key? key, this.info, this.profit, this.user})
      : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late final Info? info;
  List addinfolist = [];
  double initial = 0, initial1 = 0;
  double profit = 0;
  double profit1 = 0;
  double gross = 0;
  double nett = 0;
  double fee = 0;
  double refund = 0; 
  double manageFeeRefund = 0;
  double managefeeperday = 0;
  // String purchased_date= DateFormat("yyyy-MM-dd").format(info!.purchased_date!);
  // double durationDays = 0.00;

  @override
  void initState() {
    super.initState();
    calcProfit(widget.info!.purchased_date!);
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    String purchased_date =
        DateFormat("yyyy-MM-dd").format(widget.info!.purchased_date!);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Details'),
        backgroundColor: const Color.fromRGBO(191, 30, 46, 50),
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              shadowColor: Colors.red.shade900,
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 50, 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      child: Text(
                        "Code: " + widget.info!.code!,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        "Purchased Date: " + purchased_date.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        "Unit(s): " + widget.info!.units!,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        "Buy Price(USD): " + widget.info!.buy_price!,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),

                    // Container(
                    //   height: 40,
                    //   child: Text(
                    //     "Management Fee: ",
                    //     style: TextStyle(fontSize: 20),
                    //   ),
                    // ),
                    Container(
                      height: 50,
                      child: Text(
                        "Management Fee : " +
                            widget.info!.manage_fee!,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Text(
                        "Management Fee Refund(USD): " +
                            widget.info!.manage_fee_refund!,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Text(
                        "Target Percentage of Profit: " +
                            widget.info!.target! +
                            "%",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        "Nett Cash Out(USD): " + widget.info!.nett! ,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        "Type of GAE unit: " + widget.info!.type!,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        "Net Profit: " + profit.toStringAsFixed(2) + "%",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    // Container(
                    //   height: 40,
                    //   child: Text(
                    //     "Day(s): " + durationDays.toStringAsFixed(0),
                    //     style: TextStyle(fontSize: 20),
                    //   ),
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void calcProfit(DateTime purchased_date) {
    final now = DateTime.now();
    String purchasedDate = DateFormat("yyyy-MM-dd").format(purchased_date);
    int difference = now.difference(DateTime.parse(purchasedDate)).inDays;
    int durationDays = int.parse(difference.toString());

    print(widget.info!.type);
    print(durationDays.toString());

    setState(() {
      if (widget.info!.type == "GAE 5X") {
        initial = double.parse(widget.info!.units!)*25;
        gross = double.parse(widget.info!.nett!) - initial;
        profit =
            (gross - double.parse(widget.info!.manage_fee_refund!)) / initial * 100;
        print(double.parse(widget.info!.nett!));
        print(profit);
      } else if (widget.info!.type == "GAE 10X") {
        initial1 = double.parse(widget.info!.units!)*250;
        managefeeperday = 78.75 / 365;
        fee = managefeeperday * durationDays;
        refund = 78.75 - fee;
        gross = double.parse(widget.info!.nett!) - initial1;
        profit = (gross - refund) / initial1 * 100;

        // profit = initial1;
        print("refund = "+ refund.toString());
        print(durationDays);
        print(managefeeperday);
        print(fee);
      }
    });
    if (profit >= double.parse(widget.info!.target!)) {
      print(widget.user!.email!);
      print(widget.info!.target);
      print(widget.info!.code);
      http.post(
          Uri.parse("https://hubbuddies.com/s269426/prgi/php/notification.php"),
          body: {
            "email": widget.user!.email,
            "target": widget.info!.target,
            "code": widget.info!.code
          }).then((response) {
        print(response.body);
        if (response.body == "failed") {
          Fluttertoast.showToast(
              msg: "Error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color.fromRGBO(191, 30, 46, 50),
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: "You will received an email soon!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color.fromRGBO(191, 30, 46, 50),
              textColor: Colors.white,
              fontSize: 16.0);
        }
      });
    } else {
      Fluttertoast.showToast(
          msg: "Your profit not yet hit the target.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromRGBO(191, 30, 46, 50),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
