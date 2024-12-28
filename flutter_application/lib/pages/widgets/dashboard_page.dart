import 'package:flutter/material.dart';
import 'package:flutter_application/pages/login_page.dart';
import 'package:flutter_application/pages/widgets/account.dart';
import 'package:flutter_application/pages/widgets/activity.dart';
import 'package:flutter_application/pages/widgets/add-group.dart';
import 'package:flutter_application/pages/widgets/groups.dart';
import 'package:flutter_application/provider/auth_token_provider.dart';
import 'package:flutter_application/theme.dart';
import 'package:provider/provider.dart';

import 'friends.dart';

enum NavBarItem { Friends, Groups, AddVisitor, Activity, Emergency }

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  NavBarItem _currentNavBarItem = NavBarItem.Friends;

  void _logout(BuildContext context) {
    // Provider.of<AuthTokenProvider>(context, listen: false).logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FriendsScreenState> friendsScreenKey =
        GlobalKey<FriendsScreenState>();

    String? username = Provider.of<AuthTokenProvider>(context).authToken;

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
              'Welcome Back!',
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
          FriendsScreen(
            friendsScreenKey: friendsScreenKey,
          ),
          GroupsScreen(),
          AddGroupScreen(),
          ActivityScreen(),
          AccountScreen()
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
