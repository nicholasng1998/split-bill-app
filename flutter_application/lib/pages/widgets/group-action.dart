import 'package:flutter/material.dart';
import 'package:flutter_application/pages/widgets/sign_in.dart';
import 'package:flutter_application/pages/widgets/sign_up.dart';
import 'package:flutter_application/theme.dart';
import 'package:flutter_application/utils/bubble_indicator_painter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_application/services/itemization_service.dart';
import '../../model/expenses_details_model.dart';
import '../../model/expenses_group_model.dart';
import '../../widgets/snackbar.dart';

import '../../model/common_response_model.dart';

class GroupActionScreen extends StatefulWidget {
  @override
  _GroupActionScreenState createState() => _GroupActionScreenState();
}

class _GroupActionScreenState extends State<GroupActionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<ExpensesDetailsModel> tab1Data = [];
  List<ExpensesDetailsModel> tab2Data = [];
  List<ExpensesDetailsModel> tab3Data = [];

  bool isLoading = true; // Add a loading state
  TextEditingController paymentAmountController = TextEditingController();
  TextEditingController paymentMethodController = TextEditingController();

  TextEditingController itemAmountController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final ExpensesGroupModel group =
        ModalRoute.of(context)!.settings.arguments as ExpensesGroupModel;
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() async {
      if (_tabController.indexIsChanging) {
        if (_tabController.index == 1) {
          setState(() {
            isLoading = true; // Set loading state true when fetching data
          });
          tab2Data = await readItemization(context, group.groupId) ??
              []; // Fetch data when tab changes
          setState(() {
            isLoading = false; // Set loading state false once data is loaded
          });
        }
      }
    });
    setState(() {
      isLoading = true; // Set loading state true when fetching data
    });
    tab2Data = await readItemization(context, group.groupId) ??
        []; // Fetch data for the first tab initially
    setState(() {
      isLoading = false; // Set loading state false once data is loaded
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
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
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('Action'),
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: 'Make Payment'),
                Tab(text: 'Item List'),
                Tab(text: 'Add Item'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMakePaymentWidget(),
          _buildTabContent(tab2Data),
          _buildAddItemWidget(),
        ],
      ),
    );
  }

  Widget _buildMakePaymentWidget() {
    return Container(
        padding: const EdgeInsets.only(top: 120.0),
        child: Center(
          child: Column(children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Card(
                  elevation: 2.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                      width: 300.0,
                      height: 190.0,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 20.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextField(
                                controller: paymentAmountController,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                autocorrect: false,
                                style: const TextStyle(
                                    fontFamily: 'WorkSansSemiBold',
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.dollarSign,
                                    color: Colors.black,
                                  ),
                                  hintText: "Payment Amount",
                                  hintStyle: TextStyle(
                                      fontFamily: 'WorkSansSemiBold',
                                      fontSize: 16.0),
                                ),
                                onSubmitted: (_) {},
                              ),
                            ),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 20.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextField(
                                controller: paymentMethodController,
                                keyboardType: TextInputType.number,
                                autocorrect: false,
                                style: const TextStyle(
                                    fontFamily: 'WorkSansSemiBold',
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: const Icon(
                                    FontAwesomeIcons.moneyBill,
                                    color: Colors.black,
                                  ),
                                  hintText: "Payment Method",
                                  hintStyle: const TextStyle(
                                      fontFamily: 'WorkSansSemiBold',
                                      fontSize: 16.0),
                                ),
                                onSubmitted: (_) {
                                  ;
                                },
                                textInputAction: TextInputAction.go,
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 170.0),
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
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        'NEXT',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: 'WorkSansBold'),
                      ),
                    ),
                    onPressed: () => {},
                  ),
                )
              ],
            ),
          ]),
        ));
  }

  Widget _buildAddItemWidget() {
    return Container(
        padding: const EdgeInsets.only(top: 120.0),
        child: Center(
          child: Column(children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Card(
                  elevation: 2.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                      width: 300.0,
                      height: 190.0,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 20.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextField(
                                controller: itemAmountController,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization.words,
                                autocorrect: false,
                                style: const TextStyle(
                                    fontFamily: 'WorkSansSemiBold',
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.dollarSign,
                                    color: Colors.black,
                                  ),
                                  hintText: "Amount",
                                  hintStyle: TextStyle(
                                      fontFamily: 'WorkSansSemiBold',
                                      fontSize: 16.0),
                                ),
                                onSubmitted: (_) {},
                              ),
                            ),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 20.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextField(
                                controller: itemNameController,
                                keyboardType: TextInputType.text,
                                autocorrect: false,
                                style: const TextStyle(
                                    fontFamily: 'WorkSansSemiBold',
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: const Icon(
                                    FontAwesomeIcons.star,
                                    color: Colors.black,
                                  ),
                                  hintText: "Item Name",
                                  hintStyle: const TextStyle(
                                      fontFamily: 'WorkSansSemiBold',
                                      fontSize: 16.0),
                                ),
                                onSubmitted: (_) {
                                  ;
                                },
                                textInputAction: TextInputAction.go,
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 170.0),
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
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        'SAVE',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: 'WorkSansBold'),
                      ),
                    ),
                    onPressed: () => {_addItem(context)},
                  ),
                )
              ],
            ),
          ]),
        ));
  }

  Widget _buildTabContent(List<ExpensesDetailsModel> expensesDetailsModels) {
    if (isLoading) {
      return Center(
          child:
              CircularProgressIndicator()); // Show loading indicator while fetching data
    }

    return expensesDetailsModels.isEmpty
        ? Center(
            child:
                Text("No Data")) // Show loading indicator while fetching data
        : SingleChildScrollView(
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
                      ...expensesDetailsModels.map((expensesDetailsModel) {
                        return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 15.0),
                            child: GestureDetector(
                              onTap: () {},
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
                                      "${expensesDetailsModel.itemName} - RM${expensesDetailsModel.amount}",
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
          );
  }

  void _addItem(BuildContext context) async {
    final ExpensesGroupModel group =
        ModalRoute.of(context)!.settings.arguments as ExpensesGroupModel;

    String amount = itemAmountController.text.trim();
    String itemName = itemNameController.text.trim();

    int? amountInt = int.tryParse(amount);
    if (amountInt == null) {
      // Show an error message if the amount is not valid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid amount")),
      );
      return; // Exit the function if amount is not valid
    }

    CommonResponseModel? commonResponseModel =
        await addItemization(context, amountInt, itemName, group.groupId);

    if (commonResponseModel != null) {
      CustomSnackBar(context, const Text('Add Item Successfully'));
      itemAmountController.clear();
      itemNameController.clear();
    } else {
      CustomSnackBar(context, const Text('Add Friend Failure'));
    }
  }
}
