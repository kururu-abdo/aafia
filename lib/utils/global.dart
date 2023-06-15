

import 'dart:convert';

import 'package:aafia/data/models/response/configModel.dart';
import 'package:aafia/data/models/response/current_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

String url =  'https://afeia.net/api/v1/';
SharedPreferences? sp;
CurrentUser?  currentUser ;
String isloggedin_key='isLoggedIn';
String token='isLoggedIn';
ConfigModel configModel =ConfigModel();

double? lat;
double? lng;

Future<Map<String, String>> getApiHeaders(bool authorizationRequired) async {
  Map<String, String> apiHeader = new Map<String, String>();
  try {
    if (authorizationRequired) {
      sp = await SharedPreferences.getInstance();
      if (sp!.getString("currentUser") != null) {
        CurrentUser currentUser =
            CurrentUser.fromJson(json.decode(sp!.getString("currentUser")!));
        apiHeader.addAll({
          "Authorization": "Bearer " + currentUser.token!.toString().trim()
        });
      }
    }
    apiHeader.addAll({"Content-Type": "application/json"});
    apiHeader.addAll({"Accept": "application/json"});
    return apiHeader;
  } catch (e) {
    // log('PROBLEM WITH HEADER');
    apiHeader.addAll({"Content-Type": "application/json"});
    apiHeader.addAll({"Accept": "application/json"});
  }
  return apiHeader;
}