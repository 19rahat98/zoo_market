import 'package:flutter/material.dart';

Future<void> showErrorMessage(BuildContext context, {String? message}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Ошибка',
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                message ?? 'Произошла ошибка, повторите попытку позже',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text(
              'закрыт',
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


Future<void> twoButtonAlertWidget(BuildContext context, {required String message, required String title, VoidCallback? onTap}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                message,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text(
              'закрыт',
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: const Text(
              'зарегистрироваться',
            ),
            onPressed: (){
              Navigator.pop(context);
              onTap?.call();
            },
          ),
        ],
      );
    },
  );
}


