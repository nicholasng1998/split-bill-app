import 'package:flutter/material.dart';
import 'package:flutter_application/services/friends_service.dart';
import 'package:flutter_application/services/user_expenses_group_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../model/common_response_model.dart';
import '../../model/expenses_group_model.dart';
import '../../model/p2p_setup_model.dart';
import '../../model/user_model.dart';
import '../../services/p2p_setup_service.dart';
import '../../theme.dart';
import '../../widgets/snackbar.dart';

class AddP2PToGroupScreen extends StatefulWidget {
  @override
  AddP2PToGroupScreenState createState() => AddP2PToGroupScreenState();
}

class AddP2PToGroupScreenState extends State<AddP2PToGroupScreen> {
  List<P2PSetupModel> p2pSetupModels = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    p2pSetupModels = await findAll(context) ?? [];
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
              'Add P2P To Group',
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
                "P2P List",
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
                        ...p2pSetupModels.map((p2pSetup) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 15.0),
                            child: GestureDetector(
                              onTap: () {
                                // _addUser(
                                // context, friend.username, group.groupId);
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
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 20.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${p2pSetup.userId}",
                                    style: const TextStyle(
                                        fontFamily: "WorkSansSemiBold",
                                        fontSize: 16.0,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
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
