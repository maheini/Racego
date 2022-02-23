import 'package:flutter/material.dart';

Future<void> loggedOutDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Sitzung abgelaufen'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Ihre Sitzung ist abgelaufen. Bitte melden Sie sich neu an.')
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Anmelden'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
