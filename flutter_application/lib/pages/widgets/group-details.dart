import 'package:flutter/material.dart';
import 'package:flutter_application/model/expenses_group_model.dart';
import 'package:flutter_application/services/expenses_group_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../model/common_response_model.dart';
import '../../theme.dart';
import '../../widgets/snackbar.dart';

class GroupDetailsScreen extends StatefulWidget {
  // final GlobalKey<FriendsScreenState> friendsScreenKey;

  // FriendsScreen({Key? key, required this.friendsScreenKey}) : super(key: key);

  @override
  GroupDetailsState createState() => GroupDetailsState();
}

class GroupDetailsState extends State<GroupDetailsScreen> {
  
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
              "Group: ${group.groupName}",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.only(top: 15.0),
          child: Center(
            child: Column(children: <Widget>[
              Text(
                  "Settlement Date: ${group.dueDate != null ? DateFormat('yyyy-MM-dd').format(group.dueDate) : 'Not available'}",
                  style: const TextStyle(
                      fontFamily: "WorkSansSemiBold",
                      fontSize: 16.0,
                      color: Colors.black)),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Card(
                          color: Colors.red,
                          child: Container(
                            width: 150,
                            height: 150,
                            child: Center(child: Text("Item 1")),
                          ),
                        ),
                        Card(
                          color: Colors.red,
                          child: Container(
                            width: 150,
                            height: 150,
                            child: Center(child: Text("Item 1")),
                          ),
                        ),
                        Card(
                          color: Colors.red,
                          child: Container(
                            width: 150,
                            height: 150,
                            child: Center(child: Text("Item 1")),
                          ),
                        ),
                      ],
                    )),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: Text(
                    "Total Outstanding Amount: RM${group.outstandingAmount}",
                    style: const TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        fontSize: 16.0,
                        color: Colors.black)),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Add your onPressed logic here
                          },
                          child: Text("Add User"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Add your onPressed logic here
                          },
                          child: Text("Add PSP"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Add your onPressed logic here
                          },
                          child: Text("Action"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Add your onPressed logic here
                          },
                          child: Text("Transaction History"),
                        ),
                      ),
                    ]),
                  )),
            ]),
          )),
    );
  }
}
