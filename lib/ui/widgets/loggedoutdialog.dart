import 'package:flutter/material.dart';
import 'package:racego/generated/l10n.dart';

Future<void> loggedOutDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(S.current.session_expired),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[Text(S.current.session_expired_details)],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(S.current.sign_in),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
