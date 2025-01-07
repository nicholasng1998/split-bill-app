import 'package:flutter/material.dart';
import 'package:flutter_application/model/user_model.dart';
import 'package:flutter_application/pages/widgets/add-friends.dart';
import 'package:flutter_application/services/p2p_setup_service.dart';

import '../../model/p2p_setup_model.dart';
import '../../services/friends_service.dart';
import '../../theme.dart';

class P2PListScreen extends StatefulWidget {
  @override
  P2PListScreenState createState() => P2PListScreenState();
}

class P2PListScreenState extends State<P2PListScreen> {
  List<P2PSetupModel> p2pList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    p2pList = await findAll(context) ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
              'Add P2P',
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
                "P2P Merchant List",
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
                      child: Column(
                        children: <Widget>[
                          ...p2pList.map((merchant) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              child: GestureDetector(
                                onTap: () {},
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
                                    child: itemListText(merchant),
                                  ),
                                ),
                              ),
                            );
                          }).toList()
                        ],
                      ),
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

  Widget itemListText(P2PSetupModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/tncScreen', arguments: model);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Merchant Name: ${model.userIdName.toUpperCase()}',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Container(
                width: 200,
                child: Text(
                  'Lend Amount Remaining: RM${model.remainingAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
