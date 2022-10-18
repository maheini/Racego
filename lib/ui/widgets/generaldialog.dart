import 'package:flutter/material.dart';
import 'package:racego/generated/l10n.dart';

Future<bool> generalDialog(
    BuildContext context, String title, String message) async {
  return await showDialog<bool>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                ),
                child: Text(S.current.cancel_flat),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                ),
                child: Text(S.current.ok_flat),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      ) ??
      false;
}
