import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application/model/common_response_model.dart';
import 'package:flutter_application/model/expenses_details_model.dart';
import 'package:flutter_application/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application/apis.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/provider/auth_token_provider.dart';

/**
 * Itemization Add Function
 */
Future<CommonResponseModel?> addItemization(
    BuildContext context, int amount, String itemName, int groupId) async {
  final String url = ITEMIZATION_ADD;

  final String? authToken =
      Provider.of<AuthTokenProvider>(context, listen: false).authToken;

  final Map<String, dynamic> requestData = {
    'amount': amount,
    'itemName': itemName,
    'groupId': groupId,
  };

  print("Request Body for addItemization: ");
  print(requestData);

  try {
    final response = await http.post(Uri.parse(url),
        headers: {
          'auth-token': authToken ?? '',
          'Content-Type': 'application/json',
        },
        body: json.encode(requestData));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      CommonResponseModel responseModel =
          CommonResponseModel.fromJson(responseData);

      print('Response: $responseModel');
      return responseModel;
    } else {
      print('Request failed with status: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error: $e');
  } finally {
    print('Finally');
  }
  return null;
}

/**
 * Read Itemization Function
 */
Future<List<ExpensesDetailsModel>?> readItemization(
    BuildContext context, int groupId) async {
  final String url = ITEMIZATION_READ;

  final String? authToken =
      Provider.of<AuthTokenProvider>(context, listen: false).authToken;

  var params = {
    'groupId': groupId.toString(),
  };

  try {
    final Uri uri = Uri.parse(url).replace(queryParameters: params);

    final response = await http.get(uri, headers: {
      'auth-token': authToken ?? '',
    });

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
        return null;
      }

      List<dynamic> responseData = json.decode(response.body);
      print('Response: $responseData');

      List<ExpensesDetailsModel> expensesDetailsModels = responseData
          .map((expensesDetailsModel) =>
              ExpensesDetailsModel.fromJson(expensesDetailsModel))
          .toList();

      return expensesDetailsModels;
    } else {
      print('Request failed with status: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error: $e');
  } finally {
    print('Finally');
  }
  return null;
}

/**
 * Update Itemization Function
 */
Future<CommonResponseModel?> updateItemization(BuildContext context,
    int detailsId, int amount, String itemName, int groupId) async {
  final String url = ITEMIZATION_UPDATE;

  final String? authToken =
      Provider.of<AuthTokenProvider>(context, listen: false).authToken;

  final Map<String, dynamic> requestData = {
    'detailsId': detailsId,
    'amount': amount,
    'itemName': itemName,
    'groupId': groupId,
  };

  print("Request Body for updateItemization: ");
  print(requestData);

  try {
    final response = await http.post(Uri.parse(url),
        headers: {
          'auth-token': authToken ?? '',
          'Content-Type': 'application/json',
        },
        body: json.encode(requestData));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      CommonResponseModel responseModel =
          CommonResponseModel.fromJson(responseData);

      print('Response: $responseModel');
      return responseModel;
    } else {
      print('Request failed with status: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error: $e');
  } finally {
    print('Finally');
  }
  return null;
}
