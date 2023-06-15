import 'dart:io';

import 'package:aafia/data/models/base/api_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/global.dart' as global;
class BusinessRule {
  


    ApiHelper? dbHelper;



  BusinessRule(ApiHelper? _dbHelper) {
    dbHelper = _dbHelper;
  }

  Future<bool> checkConnectivity() async {
    try {
      bool isConnected;
      var _connectivity = await (Connectivity().checkConnectivity());
      if (_connectivity == ConnectivityResult.mobile) {
        isConnected = true;
      } else if (_connectivity == ConnectivityResult.wifi) {
        isConnected = true;
      } else {
        isConnected = false;
      }

      if (isConnected) {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            isConnected = true;
          }
        } on SocketException catch (_) {
          isConnected = false;
        }
      }

      return isConnected;
    } catch (e) {
      print('Exception - businessRule.dart - checkConnectivity(): ' + e.toString());
    }
    return false;
  }


  int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }
  String getCleanedNumber(String text) {
    RegExp regExp = new RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }
getSharedPreferences() async {
    try {
      global.sp = await SharedPreferences.getInstance();
    } catch (e) {
      print("Exception - businessRule.dart - _saveUser():" + e.toString());
    }
  }




}