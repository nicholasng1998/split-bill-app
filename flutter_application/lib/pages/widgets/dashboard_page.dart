import 'package:flutter/material.dart';
import 'package:flutter_application/pages/login_page.dart';
import 'package:flutter_application/pages/widgets/add_visitor_page.dart';
import 'package:flutter_application/pages/widgets/emergency_page.dart';
import 'package:flutter_application/pages/widgets/notice_page.dart';
import 'package:flutter_application/pages/widgets/payment_page.dart';
import 'package:flutter_application/theme.dart';
import 'package:flutter_application/utils/user_state.dart';
import 'package:provider/provider.dart';

import 'friends.dart';

enum NavBarItem { Friends, Payment, AddVisitor, Hello, Emergency }

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  NavBarItem _currentNavBarItem = NavBarItem.Friends;

  void _logout(BuildContext context) {
    Provider.of<UserState>(context, listen: false).logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    String? username = Provider.of<UserState>(context).username;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                CustomTheme.loginGradientStart,
                CustomTheme.loginGradientEnd
              ],
            ),
          ),
          child: AppBar(
            title: Text(
              'Welcome back!',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () => _logout(context),
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: _currentNavBarItem.index,
        children: <Widget>[
          FriendsScreen(),
          NoticeScreen(),
          PaymentScreen(username: '$username'),
          AddVisitorScreen(username: '$username'),
          EmergencyScreen(
            username: '$username',
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          currentIndex: _currentNavBarItem.index,
          onTap: (int index) {
            setState(() {
              _currentNavBarItem = NavBarItem.values[index];
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.group_add), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.group), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_activity), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: ''),
          ]),
    );
  }
}
