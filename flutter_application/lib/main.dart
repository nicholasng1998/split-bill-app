import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/pages/login_page.dart';
import 'package:flutter_application/pages/widgets/account.dart';
import 'package:flutter_application/pages/widgets/activity.dart';
import 'package:flutter_application/pages/widgets/add-friends.dart';
import 'package:flutter_application/pages/widgets/add-p2p.dart';
import 'package:flutter_application/pages/widgets/add-user-to-group.dart';
import 'package:flutter_application/pages/widgets/become_merchant.dart';
import 'package:flutter_application/pages/widgets/merchant_application.dart';
import 'package:flutter_application/pages/widgets/online-banking-confirmation.dart';
import 'package:flutter_application/pages/widgets/online-banking.dart';
import 'package:flutter_application/pages/widgets/dashboard_page.dart';
import 'package:flutter_application/pages/widgets/friends.dart';
import 'package:flutter_application/pages/widgets/group-action.dart';
import 'package:flutter_application/pages/widgets/group-details.dart';
import 'package:flutter_application/pages/widgets/groups.dart';
import 'package:flutter_application/pages/widgets/p2p-list.dart';
import 'package:flutter_application/pages/widgets/payment_methods.dart';
import 'package:flutter_application/pages/widgets/e-wallet.dart';
import 'package:flutter_application/pages/widgets/tnc.dart';
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
        MyNavigatorObserver(friendsScreenKey: friendsScreenKey, onPop: () {})
      ],
      routes: {
        '/dashboard': (context) => DashboardPage(),
        '/friendsScreen': (context) =>
            FriendsScreen(friendsScreenKey: friendsScreenKey),
        '/addFriendsScreen': (context) => AddFriendsScreen(),
        '/groupsScreen': (context) => GroupsScreen(),
        '/groupDetailsScreen': (context) => GroupDetailsScreen(),
        '/addUserToGroupScreen': (context) => AddUserToGroupScreen(),
        '/groupActionScreen': (context) => GroupActionScreen(),
        '/viewPaymentMethod': (context) => ViewPaymentMethodScreen(),
        '/eWalletScreen': (context) => EWalletScreen(),
        '/onlineBankingScreen': (context) => OnlineBankingScreen(),
        '/onlineBankingConfirmationScreen': (context) =>
            OnlineBankingConfirmationScreen(),
        '/becomeMerchantScreen': (context) => BecomeMerchantScreen(),
        '/merchantApplicationScreen': (context) => MerchantApplicationScreen(),
        '/addP2PToGroupScreen': (context) => AddP2PToGroupScreen(),
        '/p2PListScreen': (context) => P2PListScreen(),
        '/tncScreen': (context) => TncScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Split Bill Application',
      home: LoginPage(),
    );
  }
}
