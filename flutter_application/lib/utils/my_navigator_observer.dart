import 'package:flutter/material.dart';
import 'package:flutter_application/pages/widgets/friends.dart';

class MyNavigatorObserver extends NavigatorObserver {
  final GlobalKey<FriendsScreenState> friendsScreenKey;
  final Function onPop;

  MyNavigatorObserver({required this.friendsScreenKey, required this.onPop});

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute?.settings.name == '/dashboard') {
      onPop();
    }
    super.didPop(route, previousRoute);
  }
}
