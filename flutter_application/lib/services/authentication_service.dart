import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application/apis.dart';

Future<bool> login(String username, String password) async {
  var url = Uri.parse(LOGIN_API);

  var requestBody = {
    'username': username,
    'password': password,
  };

  var response = await http.post(url, body: requestBody);

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
