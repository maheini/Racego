import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> loggedOutDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context).session_expired),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(AppLocalizations.of(context).session_expired_details)
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(AppLocalizations.of(context).sign_in),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
