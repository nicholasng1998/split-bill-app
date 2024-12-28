import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/pages/login_page.dart';
import 'package:flutter_application/pages/widgets/account.dart';
import 'package:flutter_application/pages/widgets/activity.dart';
import 'package:flutter_application/pages/widgets/add-friends.dart';
import 'package:flutter_application/pages/widgets/dashboard_page.dart';
import 'package:flutter_application/pages/widgets/friends.dart';
import 'package:flutter_application/pages/widgets/groups.dart';
import 'package:flutter_application/provider/auth_token_provider.dart';
import 'package:flutter_application/utils/my_navigator_observer.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthTokenProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final GlobalKey<FriendsScreenState> friendsScreenKey =
      GlobalKey<FriendsScreenState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [
        MyNavigatorObserver(
            friendsScreenKey: friendsScreenKey,
            onPop: () {
              print("asd");
            })
      ],
      routes: {
        '/dashboard': (context) => DashboardPage(),
        '/friendsScreen': (context) =>
            FriendsScreen(friendsScreenKey: friendsScreenKey),
        '/addFriendsScreen': (context) => AddFriendsScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Split Bill Application',
      home: LoginPage(),
    );
  }
}
