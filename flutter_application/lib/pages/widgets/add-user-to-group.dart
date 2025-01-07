import 'package:flutter/material.dart';
import 'package:flutter_application/model/group_details_model.dart';
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
    List<dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;

    final GroupDetailsModel groupDetailsModel =
        arguments[0] as GroupDetailsModel;
    final ExpensesGroupModel group = arguments[1] as ExpensesGroupModel;

    List<String> existingUsers =
        groupDetailsModel.userModels.map((e) => e.name).toList();

    friendsList = friendsList
        .where((element) => !existingUsers.contains(element.name))
        .toList();

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
          child: Column(
            children: <Widget>[
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
                          if (!existingUsers.contains(friend.name)) {}

                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            child: GestureDetector(
                              onTap: () {
                                _addUser(context, friend.username,
                                    group.groupId, group);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 2.0,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                        ),
                                      ]),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 20.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${friend.name}",
                                      style: const TextStyle(
                                          fontFamily: "WorkSansSemiBold",
                                          fontSize: 16.0,
                                          color: Colors.black),
                                    ),
                                  )),
                            ),
                          );
                        }).toList()
                      ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addUser(BuildContext context, String username, int groupId,
      ExpensesGroupModel group) async {
    CommonResponseModel? commonResponseModel =
        await addUser(context, username, groupId);

    if (commonResponseModel != null) {
      showSuccessDialog(
          context, "Success", "Add friend into the group successfully!", group);
    } else {
      showErrorDialog(
          context, "Failed", "Fail to add this friend to the group");
    }
  }

  void showErrorDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.redAccent,
                size: 50.0,
              ),
              SizedBox(height: 16.0),
              Text(
                title,
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                text,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSuccessDialog(BuildContext context, String title, String text,
      ExpensesGroupModel group) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Colors.greenAccent,
                size: 50.0,
              ),
              SizedBox(height: 16.0),
              Text(
                title,
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                text,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.greenAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () => {
                  Navigator.pop(context),
                  Navigator.popAndPushNamed(context, '/groupDetailsScreen',
                      arguments: group),
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
