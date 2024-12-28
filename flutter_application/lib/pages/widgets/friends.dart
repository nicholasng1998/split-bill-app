import 'package:flutter/material.dart';
import 'package:flutter_application/model/user_model.dart';
import 'package:flutter_application/pages/widgets/add-friends.dart';

import '../../services/friends_service.dart';
import '../../theme.dart';

class FriendsScreen extends StatefulWidget {
  final GlobalKey<FriendsScreenState> friendsScreenKey;

  FriendsScreen({Key? key, required this.friendsScreenKey}) : super(key: key);

  @override
  FriendsScreenState createState() => FriendsScreenState();
}

class FriendsScreenState extends State<FriendsScreen> {
  List<UserModel> friendsList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    friendsList = await readFriends(context) ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 23.0),
        child: Center(
            child: Column(children: <Widget>[
          Text(
            "Friends",
            style: const TextStyle(
                fontFamily: "WorkSansSemiBold",
                fontSize: 25.0,
                color: Colors.black),
          ),
          Flexible(
            child: Container(
                margin: const EdgeInsets.only(top: 20.0),
                width: 300.0,
                height: 350.0,
                child: Card(
                  elevation: 2.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                      ...friendsList.map((friend) {
                        return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 15.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        Colors.white, // Button background color
                                    borderRadius: BorderRadius.circular(
                                        8.0), // Rounded corners
                                    border: Border.all(
                                      color: Colors.blue, // Border color
                                      width: 2.0, // Border width
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 3), // Shadow position
                                      ),
                                    ]),
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 20.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${friend.username}",
                                    style: const TextStyle(
                                        fontFamily: "WorkSansSemiBold",
                                        fontSize: 16.0,
                                        color: Colors.black),
                                  ),
                                )));
                      }).toList()
                    ]),
                  ),
                )),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: CustomTheme.loginGradientStart,
                  offset: Offset(1.0, 6.0),
                  blurRadius: 20.0,
                ),
                BoxShadow(
                  color: CustomTheme.loginGradientEnd,
                  offset: Offset(1.0, 6.0),
                  blurRadius: 20.0,
                ),
              ],
              gradient: LinearGradient(
                  colors: <Color>[
                    CustomTheme.loginGradientEnd,
                    CustomTheme.loginGradientStart
                  ],
                  begin: FractionalOffset(0.2, 0.2),
                  end: FractionalOffset(1.0, 1.0),
                  stops: <double>[0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: MaterialButton(
              highlightColor: Colors.transparent,
              splashColor: CustomTheme.loginGradientEnd,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                child: Text(
                  'Add Friends',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontFamily: 'WorkSansBold'),
                ),
              ),
              onPressed: () => {
                Navigator.pushNamed(
                  context,
                  '/addFriendsScreen',
                )
              },
            ),
          )
        ])));
  }
}
