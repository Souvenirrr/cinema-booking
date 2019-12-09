import 'package:flutter/material.dart';

Widget snackBar(String msg) {
  return SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: '',
        onPressed: () {
          // Some code to undo the change.
        },
      ));
}
