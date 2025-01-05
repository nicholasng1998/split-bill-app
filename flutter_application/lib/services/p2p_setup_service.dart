import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application/model/common_response_model.dart';
import 'package:flutter_application/model/p2p_setup_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application/apis.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/provider/auth_token_provider.dart';

/**
 * Add Friends Function
 */
Future<CommonResponseModel?> applyP2P(
    BuildContext context, double lendAmount) async {
  final String url = P2P_SETUP_APPLY;

  final String? authToken =
      Provider.of<AuthTokenProvider>(context, listen: false).authToken;

  final Map<String, dynamic> requestData = {
    'lendAmount': lendAmount,
  };

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
 * Find All P2P Function
 */
Future<List<P2PSetupModel>?> findAll(BuildContext context) async {
  final String url = P2P_SETUP_FIND_ALL;
  final String? authToken = Provider.of<AuthTokenProvider>(context, listen: false).authToken;

  try {
    final response = await http.get(Uri.parse(url), headers: {
      'auth-token': authToken ?? '',
    });

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
        return null;
      }
      List<dynamic> responseData = json.decode(response.body);
      print('Response: $responseData');

      List<P2PSetupModel> p2pSetupModels =
          responseData.map((user) => P2PSetupModel.fromJson(user)).toList();

      print(p2pSetupModels);
      return p2pSetupModels;
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