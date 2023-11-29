import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ReusableMethods{

  checkConnectivity(BuildContext context)async{
    var connection = await Connectivity().checkConnectivity();
    if(connection != ConnectivityResult.mobile && connection != ConnectivityResult.wifi){
      if(!context.mounted)return;
      displaySnakBar("Your Internet Is Not Working, Check Connection And Try Again", context);
    }
  }

  displaySnakBar(String message, BuildContext context){
    var snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}