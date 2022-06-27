import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:prgi/infoscreen.dart';
import 'package:http/http.dart' as http;
import 'package:prgi/loginscreen.dart';
import 'package:prgi/user.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordControllera = TextEditingController();
  final TextEditingController _passwordControllerb = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.fromLTRB(30, 60, 30, 0),
                  child: Image.asset('assets/images/LOGO.png', scale: 1.3)),
              const SizedBox(height: 1),
              Card(
                shadowColor: Colors.red.shade900,
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 6),
                  child: Column(
                    children: [
                      const Text(
                        'REGISTRATION',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            icon:
                                Icon(Icons.email, color: Colors.red.shade900)),
                      ),
                      TextField(
                        controller: _passwordControllera,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            icon: Icon(Icons.lock, color: Colors.red.shade900)),
                        obscureText: true,
                      ),
                      TextField(
                        controller: _passwordControllerb,
                        decoration: InputDecoration(
                            labelText: 'Enter Password Again',
                            icon: Icon(Icons.lock, color: Colors.red.shade900)),
                        obscureText: true,
                      ),
                      const SizedBox(height: 10),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minWidth: 150,
                        height: 40,
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: _onRegister,
                        color: Colors.red[900],
                      ),
                      const SizedBox(height: 2),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                child: const Text(
                  'Already Register!',
                  style: TextStyle(fontSize: 14),
                ),
                onTap: _alreadyRegister,
              ),
              const SizedBox(height: 5),
            ],
          ),
        )),
      ),
    );
  }

  void _alreadyRegister() {
    User user = User(
      email: _emailController.text.toString(),
    );
    Navigator.push(context,
        MaterialPageRoute(builder: (content) => LoginScreen(user: user)));
  }

  void _onRegister() {
    String _email = _emailController.text.toString();
    String _passworda = _passwordControllera.text.toString();
    String _passwordb = _passwordControllerb.text.toString();

    if (_email.isEmpty || _passworda.isEmpty || _passwordb.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please Enter Your Email and Password..",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromRGBO(191, 30, 46, 50),
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text("Register new user"),
            content: const Text("Are you sure?"),
            actions: [
              TextButton(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _registerUser(_email, _passworda);
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

  void _registerUser(String email, String password) {
    http.post(
        Uri.parse("https://hubbuddies.com/s269426/prgi/php/register_user.php"),
        body: {"email": email, "password": password}).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Welcome! Your Registration is Successed!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromRGBO(191, 30, 46, 50),
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Registration failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromRGBO(191, 30, 46, 50),
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }
}
