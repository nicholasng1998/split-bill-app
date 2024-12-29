import 'package:flutter/material.dart';
import 'package:flutter_application/model/expenses_group_model.dart';
import 'package:flutter_application/model/group_details_model.dart';
import 'package:flutter_application/services/expenses_group_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../model/common_response_model.dart';
import '../../theme.dart';
import '../../widgets/snackbar.dart';

class GroupDetailsScreen extends StatefulWidget {
  @override
  GroupDetailsState createState() => GroupDetailsState();
}

class GroupDetailsState extends State<GroupDetailsScreen> {
  GroupDetailsModel? groupDetailsModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    final ExpensesGroupModel group =
        ModalRoute.of(context)!.settings.arguments as ExpensesGroupModel;
    super.didChangeDependencies();
    var result = await getGroupDetails(context, group.groupId) ?? [];

    if (result is GroupDetailsModel) {
      groupDetailsModel = result;
    } else {
      groupDetailsModel = null; // Handle invalid or error case if needed
    }

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
                        ...groupDetailsModel?.userModels.map((model) {
                              return Card(
                                color: Colors.red,
                                child: Container(
                                  width: 150,
                                  height: 100,
                                  child: Center(
                                      child: Text("${model.username}",
                                          style: const TextStyle(
                                              fontFamily: "WorkSansSemiBold",
                                              fontSize: 16.0,
                                              color: Colors.black))),
                                ),
                              );
                            }) ??
                            [],
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
                      if (groupDetailsModel?.isHost ?? false)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/addUserToGroupScreen',
                                  arguments: group);
                            },
                            child: Text("Add User"),
                          ),
                        ),
                      if (groupDetailsModel?.isHost ?? false)
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
                            Navigator.pushNamed(context, '/groupActionScreen',
                                arguments: group);
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
