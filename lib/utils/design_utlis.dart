import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; 

class DesignUtlis {
  static flutterToast(msg) {
    Fluttertoast.showToast(
        msg: msg, backgroundColor: Colors.black.withOpacity(0.75));
  }
}
