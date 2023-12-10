import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ReusableMethods{

  Future<int> checkConnectivity(BuildContext context)async{
    var connection = await Connectivity().checkConnectivity();
    if(connection != ConnectivityResult.mobile && connection != ConnectivityResult.wifi){
      if(!context.mounted)return 0;
      displaySnakBar("Your Internet Is Not Working, Check Connection And Try Again", context);
      return 0;//for no connection
    }
    else
      {
        print("for connection it is found");
        return 1;//for connection
      }


  }

  displaySnakBar(String message, BuildContext context){
    var snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}