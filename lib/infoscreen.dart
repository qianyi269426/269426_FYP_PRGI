import 'package:flutter/material.dart';
import 'package:prgi/mainscreen.dart';
import 'package:prgi/managescreen.dart';
import 'package:prgi/reportscreen.dart';
import 'package:prgi/user.dart';

class InfoScreen extends StatefulWidget {
  final int? curtab;
  final User? user;
  const InfoScreen({Key? key, this.curtab, this.user}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  int _currentIndex = 0;
  late List<Widget> list;

  @override
  void initState() {
    list = [
      ManageScreen(user: widget.user),
      MainScreen(user: widget.user),
      ReportScreen(user: widget.user)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.attach_money,
              ),
              label: 'Manage'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
            ),
            label: 'Homepage',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.receipt_long,
            ),
            label: 'Report',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
