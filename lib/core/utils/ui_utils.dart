import 'package:flutter/material.dart' show Color, Colors;
import 'package:fluttertoast/fluttertoast.dart';

void notifyUser({
  required String message,
  required bool success,
  Color? color,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.SNACKBAR,
    timeInSecForIosWeb: 1,
    backgroundColor:
        color != null ? color : (success == true ? Colors.green : Colors.red),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
