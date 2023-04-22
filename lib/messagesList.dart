import 'package:flutter/material.dart';

class MessagesListItemWidget extends StatelessWidget {
  final String sender;
  final DateTime date;
  final String body;

  MessagesListItemWidget({required this.sender, required this.date, required this.body});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('$sender [$date]'),
      subtitle: Text('$body'),
    );
  }
}
