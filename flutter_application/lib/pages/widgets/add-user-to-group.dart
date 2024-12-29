import 'package:flutter/material.dart';
import 'package:flutter_application/services/friends_service.dart';
import 'package:flutter_application/services/user_expenses_group_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../model/common_response_model.dart';
import '../../model/expenses_group_model.dart';
import '../../model/user_model.dart';
import '../../theme.dart';
import '../../widgets/snackbar.dart';

class AddUserToGroupScreen extends StatefulWidget {
  @override
  AddUserToGroupScreenState createState() => AddUserToGroupScreenState();
}

class AddUserToGroupScreenState extends State<AddUserToGroupScreen> {
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
    final ExpensesGroupModel group =
        ModalRoute.of(context)!.settings.arguments as ExpensesGroupModel;

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
              'Add User',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Container(
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
                  height: 600.0,
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
                              child: GestureDetector(
                                onTap: () {
                                  _addUser(
                                      context, friend.username, group.groupId);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors
                                            .white, // Button background color
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
                                            offset:
                                                Offset(0, 3), // Shadow position
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
                                    )),
                              ));
                        }).toList()
                      ]),
                    ),
                  )),
            ),
          ]))),
    );
  }

  void _addUser(BuildContext context, String username, int groupId) async {
    final ExpensesGroupModel group =
        ModalRoute.of(context)!.settings.arguments as ExpensesGroupModel;

    CommonResponseModel? commonResponseModel =
        await addUser(context, username, groupId);

    if (commonResponseModel != null) {
      CustomSnackBar(context, const Text('Add User Successfully'));
      Navigator.popAndPushNamed(context, '/groupDetailsScreen',
          arguments: group);
    } else {
      CustomSnackBar(context, const Text('Add Friend Failure'));
    }
  }
}
