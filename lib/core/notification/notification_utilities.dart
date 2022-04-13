import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

Future requestPermission(context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Allow Notifications'),
      content: Text('Our app would like to send you notifications'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Don\'t Allow',
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ),
        TextButton(
          onPressed: () => AwesomeNotifications()
              .requestPermissionToSendNotifications()
              .then((_) => Navigator.pop(context)),
          child: Text(
            'Allow',
            style: TextStyle(
              color: Colors.teal,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
