import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application/apis.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/provider/auth_token_provider.dart';

/**
 * Login Function
 */
Future<String> login(String username, String password) async {
  final String url = LOGIN_API;

  var params = {
    'username': username,
    'password': password,
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      body: params,
    );

    if (response.statusCode == 200) {
      String responseData = response.body;
      print('Response: $responseData');
      return responseData;
    } else {
      print('Request failed with status: ${response.statusCode}');
      return "";
    }
  } catch (e) {
    print('Error: $e');
  } finally {
    print('Finally');
  }
  return "";
}
