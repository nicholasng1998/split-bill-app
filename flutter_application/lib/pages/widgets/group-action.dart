import 'package:flutter/material.dart';
import 'package:flutter_application/model/transaction_history_model.dart';
import 'package:flutter_application/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_application/services/itemization_service.dart';
import '../../model/expenses_details_model.dart';
import '../../model/expenses_group_model.dart';

import '../../model/common_response_model.dart';

class GroupActionScreen extends StatefulWidget {
  @override
  _GroupActionScreenState createState() => _GroupActionScreenState();
}

class _GroupActionScreenState extends State<GroupActionScreen>
    with TickerProviderStateMixin {
  // Initialize
  String selectedPaymentMethod = 'Online Banking';
  List<String> paymentMethods = ['Online Banking', 'E-Wallet'];

  late TabController _tabController;
  List<ExpensesDetailsModel> tab2Data = [];

  bool isLoading = true;
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
            isLoading = true;
          });
          tab2Data = await readItemization(context, group.groupId) ?? [];
          setState(() {
            isLoading = false;
          });
        }
      }
    });
    setState(() {
      isLoading = true;
    });
    tab2Data = await readItemization(context, group.groupId) ?? [];
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ExpensesGroupModel group =
        ModalRoute.of(context)!.settings.arguments as ExpensesGroupModel;

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
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushNamed(context, "/groupDetailsScreen",
                    arguments: group);
              },
            ),
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
          _buildItemListContent(tab2Data),
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
                                keyboardType: TextInputType.number,
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
                              child: paymentMethodDropdown(),
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
                    onPressed: () => {
                      makePaymentNext(context),
                    },
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

  Widget _buildItemListContent(
      List<ExpensesDetailsModel> expensesDetailsModels) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return expensesDetailsModels.isEmpty
        ? Center(child: Text("No Data"))
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
                                    child: itemListText(expensesDetailsModel),
                                  )),
                            ));
                      }).toList()
                    ]),
                  ),
                )),
          );
  }

  Widget itemListText(ExpensesDetailsModel expensesDetailsModel) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${expensesDetailsModel.itemName}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Added By: ${expensesDetailsModel.createdByName}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Spacer(),
        Container(
          height: 42,
          alignment: Alignment.center,
          child: Text(
            'RM ${expensesDetailsModel.amount.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  void _addItem(BuildContext context) async {
    final ExpensesGroupModel group =
        ModalRoute.of(context)!.settings.arguments as ExpensesGroupModel;

    String amount = itemAmountController.text.trim();
    String itemName = itemNameController.text.trim();

    int? amountInt = int.tryParse(amount);
    if (amountInt == null) {
      showErrorDialog(context, "Failed", "Please input amount!");
      return;
    }

    if (itemName.isEmpty) {
      showErrorDialog(context, "Failed", "Please input item name!");
      return;
    }

    if (group.status != "waiting") {
      showErrorDialog(context, "Failed",
          "Group already started or closed, please do not add more item!");
      return;
    }

    CommonResponseModel? commonResponseModel =
        await addItemization(context, amountInt, itemName, group.groupId);

    if (commonResponseModel != null) {
      showSuccessDialog(context, "Success", "Add item successfully!");
      itemAmountController.clear();
      itemNameController.clear();
    } else {
      showErrorDialog(context, "Failed", "Fail to add item!");
    }
  }

  Widget paymentMethodDropdown() {
    return Row(
      children: [
        Icon(
          FontAwesomeIcons.moneyBill,
          color: Colors.black,
        ),
        SizedBox(width: 20),
        DropdownButton<String>(
          value: selectedPaymentMethod,
          onChanged: (String? newValue) {
            setState(() {
              selectedPaymentMethod = newValue!;
            });
          },
          items: paymentMethods.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          underline: Container(),
        ),
      ],
    );
  }

  void makePaymentNext(BuildContext context) {
    final ExpensesGroupModel group =
        ModalRoute.of(context)!.settings.arguments as ExpensesGroupModel;

    TransactionHistoryModel transactionHistoryModel = TransactionHistoryModel(
      transactionId: 0,
      userId: 0,
      transactionType: '',
      transactionDate: DateTime.now(),
      transactionAmount: 0.0,
      groupId: 0,
      userIdName: '',
    );

    double? amountDouble = double.tryParse(paymentAmountController.text.trim());

    transactionHistoryModel.transactionType = selectedPaymentMethod;
    transactionHistoryModel.groupId = group.groupId;
    transactionHistoryModel.transactionAmount = amountDouble ?? 0;

    if (amountDouble == null) {
      showErrorDialog(context, "Failed", "Please input payment amount!");
      return;
    }

    if (group.status != "started") {
      showErrorDialog(context, "Failed",
          "The group not yet started. Please ask the host to start the group!");
      return;
    }

    paymentAmountController.clear();

    if (selectedPaymentMethod == "E-Wallet") {
      Navigator.pushNamed(context, "/eWalletScreen",
          arguments: [transactionHistoryModel, group]);
    } else if (selectedPaymentMethod == "Online Banking") {
      Navigator.pushNamed(context, "/onlineBankingScreen",
          arguments: [transactionHistoryModel, group]);
    }
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
