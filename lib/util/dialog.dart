import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialog {
  static Future<String> prompt(
    BuildContext context,
  ) {
    TextEditingController controller = new TextEditingController();

    Completer completer = new Completer<String>();

    showDialog<String>(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Center(child: Text("Products")),
            contentPadding: const EdgeInsets.all(16.0),
            content: SizedBox(
              height: 100.0,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: new TextField(
                        controller: controller,
                        onChanged: (String value) {},
                        autofocus: true,
                        decoration: new InputDecoration(),
                      ))
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              new FlatButton(
                  child: Text('Submit'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    completer.complete();
                  })
            ],
          );
        });
    return completer.future;
  }
}
