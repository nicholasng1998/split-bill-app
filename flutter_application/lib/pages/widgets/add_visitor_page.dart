import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application/apis.dart';

class AddVisitorScreen extends StatefulWidget {
  final String username;
  AddVisitorScreen({required this.username});
  @override
  _AddVisitorScreen createState() => _AddVisitorScreen();
}

class _AddVisitorScreen extends State<AddVisitorScreen> {
  bool _isButtonClicked = false;
  void _handleButtonClick() {
    setState(() {
      _isButtonClicked = !_isButtonClicked;
    });
  }

  void redirectBackToList(String data) {
    setState(() {
      _isButtonClicked = !_isButtonClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isButtonClicked
          ? AddVisitorStatus(
              username: widget.username, callback: redirectBackToList)
          : AddVisitorRequest(
              username: widget.username,
            ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'addVisitorButton',
        onPressed: _handleButtonClick,
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddVisitorStatus extends StatefulWidget {
  final String username;
  final Function(String) callback;
  AddVisitorStatus({required this.username, required this.callback});

  @override
  _AddVisitorStatus createState() => _AddVisitorStatus();
}

class _AddVisitorStatus extends State<AddVisitorStatus> {
  String base64Image = '';
  TextEditingController nameController = TextEditingController();
  Future<void> createQrCode() async {
    print("username");

    print(widget.username);
    Map<String, dynamic> data = {
      'name': nameController.text.trim(),
      'username': widget.username,
    };

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    print(data);
    final response = await http.post(Uri.parse(VISITOR_PASS_CREATE_API),
        headers: headers, body: json.encode(data));

    if (response.statusCode == 200) {
      setState(() {
        base64Image = response.body;
      });
      print(response.body);
      showImageDialog();
    } else {
      // Handle API error
      print('Failed to fetch image: ${response.statusCode}');
    }
  }

  void showImageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create Successfully'),
          content: Container(
            width: 300,
            height: 300,
            child: Image.memory(
              base64Decode(base64Image),
              fit: BoxFit.cover,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => {widget.callback('any'), Navigator.pop(context)},
              child: Text('OK'),
            )
          ],
        );
      },
    );
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 16.0),
              Center(
                child: Text('Add Visitor Form'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please input visitor name.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Create QR Code'),
                onPressed: () {
                  createQrCode();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class VisitorResponseModel {
  final String visitorName;
  final String imageStr;
  final String status;

  VisitorResponseModel({
    required this.visitorName,
    required this.imageStr,
    required this.status,
  });

  factory VisitorResponseModel.fromJson(Map<String, dynamic> json) {
    return VisitorResponseModel(
      visitorName: json['visitorName'],
      imageStr: json['imageStr'],
      status: json['status'],
    );
  }
}

class AddVisitorRequest extends StatefulWidget {
  final String username;
  AddVisitorRequest({required this.username});

  @override
  _AddVisitorRequest createState() => _AddVisitorRequest();
}

class _AddVisitorRequest extends State<AddVisitorRequest> {
  @override
  void initState() {
    super.initState();
    // fetchVisitorHistoryFromAPI(widget.username);
  }

  Future<void> fetchVisitorHistoryFromAPI(String username) async {
    final queryParameters = {'username': username};
    final uri = Uri.parse(VISITOR_PASS_READ_API)
        .replace(queryParameters: queryParameters);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> contentList = jsonData['content'];
      final List<VisitorResponseModel> visitorResponseModel =
          contentList.map((item) {
        return VisitorResponseModel.fromJson(item);
      }).toList();

      setState(() {
        tableData = visitorResponseModel;
      });
    }
  }

  List<VisitorResponseModel> tableData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(scrollDirection: Axis.vertical, children: [
      SizedBox(height: 16.0),
      Center(
        child: Text('Visitor History'),
      ),
      SizedBox(height: 16.0),
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Visitor Name')),
            DataColumn(label: Text('QR Code')),
            DataColumn(label: Text('Status')),
          ],
          rows: tableData.map((data) {
            return DataRow(
              cells: [
                DataCell(Text(data.visitorName)),
                DataCell(
                  Image.memory(
                    base64Decode(data.imageStr),
                    fit: BoxFit.cover,
                  ),
                ),
                DataCell(Text(data.status)),
              ],
            );
          }).toList(),
        ),
      )
    ]));
  }
}
