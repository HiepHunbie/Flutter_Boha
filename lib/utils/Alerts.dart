
import 'package:boha/model/ErrorData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alerts{
   void _showAlertError(BuildContext context, List<ErrorData> value) {
    String result = "";
    for(int i = 0;i< value.length;i++){
      result = result + value[i].message.toString() + "\n";
    }
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text("Error"),
              content: Text(result.trim()),
            )
    );
  }
}
