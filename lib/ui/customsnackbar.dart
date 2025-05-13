import 'package:flutter/material.dart';

class Customsnackbar extends SnackBar {
  Customsnackbar({
    Key? key,
    // required super.content,
    required String message,
    String btnLabel = 'Ok',
    Duration duration = const Duration(seconds: 2),
    VoidCallback? ooOk,
  }) : super(
         key: key,
         content: Text(message),
         duration: duration,
         action: SnackBarAction(
           label: btnLabel,
           onPressed: () {
             if (ooOk != null) {
               ooOk();
             }
           },
         ),
       );
}
