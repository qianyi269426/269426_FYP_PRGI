import 'package:flutter/material.dart';
import 'package:prgi/ratesmodel.dart';
import 'package:prgi/user.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  final User? user;
  const MainScreen({Key? key, this.user}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<RatesModel> result;
  late Future<Map> allcurrencies;
  final formkey = GlobalKey<FormState>();
  final TextEditingController _usd = TextEditingController();
  final TextEditingController _myr = TextEditingController();

  @override
  void initState(){
    super.initState();
    setState((){
      result = fetchrates();
      // allcurrencies = fetchcurrencies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
        backgroundColor: const Color.fromRGBO(191, 30, 46, 50),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: const Text("GAE INFO",
                    style: TextStyle(fontSize: 30)),
              ),
              // Card(
              //   shadowColor: Colors.red.shade900,
              //   margin: const EdgeInsets.fromLTRB(20, 15, 20, 20),
              //   elevation: 10,
              //   child: Padding(
              //     padding: const EdgeInsets.fromLTRB(30, 10, 60, 20),
              //     child: Column(
              //       children: [
              //         Container(
              //           child: Column(
              //             children: [
              //               const Text("LONDON METAL EXCHANGE(LME)",
              //                   style: TextStyle(
              //                       fontSize: 20, fontWeight: FontWeight.bold)),
              //               const Text("Please input current exchange: ",
              //                   style: TextStyle(fontSize: 18)),
              //             ],
              //           ),
              //         ),
              //         Container(
              //           child: Column(
              //             children: [
              //               Row(
              //                 children: [
              //                   const Expanded(
              //                       flex: 2,
              //                       child: Text('USD',
              //                           style: TextStyle(fontSize: 18))),
              //                   Expanded(
              //                     flex: 3,
              //                     child: TextField(
              //                       controller: _usd,
              //                       keyboardType: TextInputType.emailAddress,
              //                     ),
              //                   ),
              //                   const Expanded(
              //                       flex: 5,
              //                       child: Text('per gram',
              //                           style: TextStyle(fontSize: 18))),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //         Container(
              //           child: Column(
              //             children: [
              //               Row(
              //                 children: [
              //                   const Expanded(
              //                       flex: 2,
              //                       child: Text("USD 1 = MYR ",
              //                           style: TextStyle(fontSize: 18))),
              //                   Expanded(
              //                     flex: 2,
              //                     child: TextField(
              //                       controller: _myr,
              //                       keyboardType: TextInputType.emailAddress,
              //                     ),
              //                   ),
              //                   const Expanded(
              //                       flex: 1,
              //                       child: Text("",
              //                           style: TextStyle(fontSize: 18))),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //         const SizedBox(
              //           height: 10,
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              Card(
                shadowColor: Colors.red.shade900,
                margin: const EdgeInsets.fromLTRB(20, 15, 20, 20),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 70, 20),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        child: Column(
                          children: [
                            const Text("GOLD ASSET ENHANCE",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const Text("GAE 5X: USD 25 per unit",
                                style: TextStyle(fontSize: 18)),
                            const Text("Management Fee: USD 3.5",
                                style: TextStyle(fontSize: 18)),
                            const Text("GAE 10X: USD 250 per unit",
                                style: TextStyle(fontSize: 18)),
                            const Text("Management Fee: USD 78.75",
                                style: TextStyle(fontSize: 18)),
                            // Text(widget.user!.email!),
                            // print(widget.user!.email);
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Future<RatesModel> fetchrates() async {
    var response = await http.get(Uri.parse(
      'https://openexchangerates.org/api/latest.json?app_id=676e8f9a2dcc4597b0ceb7af63d48166'
    ));
    final result = ratesModelFromJson(response.body);
    return result;
    
  }

  
}
