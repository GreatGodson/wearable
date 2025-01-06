import 'package:flutter/material.dart';

import '../../../core/framework/navigator/navigator.dart';

void showDialogComponent(
  VoidCallback onOk,
  String title,
  String description,
) {
  showDialog(
    barrierDismissible: false,
    context: NavigationHelper.navigatorContext!,
    builder: (BuildContext context) {
      return AlertDialog.adaptive(
        title: Text(title),
        content: Text(
          description,
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: onOk,
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
