import 'package:flutter/material.dart';
import 'package:flutter_application/model/expenses_group_model.dart';
import 'package:flutter_application/model/group_details_model.dart';
import 'package:flutter_application/model/transaction_history_model.dart';
import 'package:flutter_application/services/expenses_group_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../model/common_response_model.dart';
import '../../theme.dart';

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
    GroupDetailsModel? result = await getGroupDetails(context, group.groupId);
    print("didChangeDependencies here");
    print(groupDetailsModel?.transactionHistoryModels.toString());
    print(result?.expensesGroupModel.toString());

    print(groupDetailsModel?.expensesDetailsModels);

    setState(() {
      groupDetailsModel = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    ExpensesGroupModel? group = groupDetailsModel?.expensesGroupModel;

    // final ExpensesGroupModel group =
    // ModalRoute.of(context)!.settings.arguments as ExpensesGroupModel;

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
              "${group?.groupName.toUpperCase()}",
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushNamed(context, "/dashboard");
              },
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 15.0),
        child: Center(
          child: Column(
            children: <Widget>[
              if (group != null) settlementDateHeader(group),
              if (group != null) groupStatusText(group),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...groupDetailsModel?.userModels.map(
                            (model) {
                              return Card(
                                color: Colors.red,
                                child: Container(
                                  width: 100,
                                  height: 50,
                                  child: Center(
                                      child: Text("${model.name}",
                                          style: const TextStyle(
                                              fontFamily: "WorkSansSemiBold",
                                              fontSize: 16.0,
                                              color: Colors.black))),
                                ),
                              );
                            },
                          ) ??
                          [],
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "Total Outstanding Amount: RM${group?.outstandingAmount.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontFamily: "WorkSansSemiBold",
                      fontSize: 16.0,
                      color: Colors.black),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: <Widget>[
                    if (group != null) addUserButton(group),
                    if (group != null) addActionButton(group),
                    if (group != null) startOrCloseGroup(context, group),
                  ]),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "Transaction History",
                  style: const TextStyle(
                      fontFamily: "WorkSansSemiBold",
                      fontSize: 16.0,
                      color: Colors.black),
                ),
              ),
              transactionHistory(),
            ],
          ),
        ),
      ),
    );
  }

  Widget transactionHistory() {
    List<TransactionHistoryModel> transactionHistoryList =
        groupDetailsModel?.transactionHistoryModels ?? [];
    return Flexible(
      child: Container(
        margin: const EdgeInsets.only(top: 20.0),
        width: 350.0,
        height: 600.0,
        child: Card(
          elevation: 2.0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ...transactionHistoryList.map(
                  (model) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Button background color
                          borderRadius:
                              BorderRadius.circular(8.0), // Rounded corners
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
                          ],
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 20.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: itemListText(model),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemListText(TransactionHistoryModel transactionHistoryModel) {
    String formattedDate = DateFormat('yyyy-MM-dd h:mma')
        .format(transactionHistoryModel.transactionDate);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${formattedDate}',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Container(
              width: 250,
              child: Text(
                '${transactionHistoryModel.userIdName} has paid RM${transactionHistoryModel.transactionAmount.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                softWrap: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget addActionButton(ExpensesGroupModel group) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/groupActionScreen', arguments: group);
        },
        child: Text("Action"),
      ),
    );
  }

  Widget addP2PButton(ExpensesGroupModel group) {
    if (groupDetailsModel?.isHost ?? false) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/addP2PToGroupScreen',
                arguments: group);
          },
          child: Text("Add P2P"),
        ),
      );
    }
    return Text("");
  }

  Widget addUserButton(ExpensesGroupModel group) {
    if (groupDetailsModel?.isHost ?? false) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ElevatedButton(
          onPressed: () {
            if (group.status == "started") {
              showErrorDialog(context, "Failed",
                  "Group has started. Please do not add more user to this group!");
              return;
            }

            if (group.status == "closed") {
              showErrorDialog(context, "Failed",
                  "Group has closed. Please do not add more user to this group!");
              return;
            }

            print("addUserButton here");
            print(groupDetailsModel?.userModels.toString());

            Navigator.pushNamed(context, '/addUserToGroupScreen',
                arguments: [groupDetailsModel, group]);
          },
          child: Text("Add User"),
        ),
      );
    }
    return Text("");
  }

  Widget groupStatusText(ExpensesGroupModel group) {
    return Text(
      "Group Status: ${group.status.toUpperCase()}",
      style: const TextStyle(
          fontFamily: "WorkSansSemiBold", fontSize: 20.0, color: Colors.black),
    );
  }

  Widget settlementDateHeader(ExpensesGroupModel group) {
    return Text(
      "Settlement Date: ${DateFormat('yyyy-MM-dd').format(group.dueDate)}",
      style: const TextStyle(
          fontFamily: "WorkSansSemiBold", fontSize: 20.0, color: Colors.black),
    );
  }

  Widget startOrCloseGroup(BuildContext context, ExpensesGroupModel group) {
    if (group.status == "waiting") {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ElevatedButton(
          onPressed: () {
            updateToStarted(context, group.groupId);
            showSuccessDialog(
                context, "Success", "Updated group status to STARTED");
            setState(() {
              group.status = "started";
            });
          },
          child: Text("Start Group"),
        ),
      );
    } else if (group.status == "started") {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ElevatedButton(
          onPressed: () {
            if (group.outstandingAmount > 0) {
              showErrorDialog(context, "Failed",
                  "Please clear the outstanding amount before closing the group!");
              return;
            }

            updateToClosed(context, group.groupId);
            showSuccessDialog(
                context, "Success", "Updated group status to CLOSED");
            setState(() {
              group.status = "closed";
            });
          },
          child: Text("Close Group"),
        ),
      );
    } else if (group.status == "closed") {
      return Text("");
    }
    return Text("");
  }

  void showSuccessDialog(BuildContext context, String title, String text) {
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
}
