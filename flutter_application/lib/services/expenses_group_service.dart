import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application/model/common_response_model.dart';
import 'package:flutter_application/model/group_details_model.dart';
import 'package:flutter_application/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application/apis.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/provider/auth_token_provider.dart';

/**
 * Create Group Function
 */
Future<CommonResponseModel?> createGroup(BuildContext context, String groupName,
    int amount, DateTime dueDate) async {
  final String url = EXPENSES_GROUP_CREATE;

  final String? authToken =
      Provider.of<AuthTokenProvider>(context, listen: false).authToken;

  String dueDateString = dueDate.toIso8601String();

  final Map<String, dynamic> requestData = {
    'groupName': groupName,
    'totalExpenses': amount,
    'dueDate': dueDateString,
  };

  print("Request Body for create group: ");
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
 * Update to started Function
 */
Future<CommonResponseModel?> updateToStarted(
    BuildContext context, int groupId) async {
  final String url = EXPENSES_GROUP_UPDATE_TO_STARTED;

  final String? authToken = Provider.of<AuthTokenProvider>(context).authToken;

  var params = {
    'groupId': groupId,
  };

  try {
    final response = await http.post(Uri.parse(url),
        headers: {
          'auth-token': authToken ?? '',
        },
        body: params);

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
 * Update to closed Function
 */
Future<CommonResponseModel?> updateToClosed(
    BuildContext context, int groupId) async {
  final String url = EXPENSES_GROUP_UPDATE_TO_CLOSED;

  final String? authToken = Provider.of<AuthTokenProvider>(context).authToken;

  var params = {
    'groupId': groupId,
  };

  try {
    final response = await http.post(Uri.parse(url),
        headers: {
          'auth-token': authToken ?? '',
        },
        body: params);

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
 * Get Group Details Function
 */
Future<GroupDetailsModel?> getGroupDetails(
    BuildContext context, int groupId) async {
  final String url = EXPENSES_GROUP_GET_GROUP_DETAILS;

  final String? authToken = Provider.of<AuthTokenProvider>(context).authToken;

  var params = {
    'groupId': groupId.toString(),
  };

  try {
    final Uri uri = Uri.parse(url).replace(queryParameters: params);

    final response = await http.get(uri, headers: {
      'auth-token': authToken ?? '',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      GroupDetailsModel responseModel =
          GroupDetailsModel.fromJson(responseData);

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
