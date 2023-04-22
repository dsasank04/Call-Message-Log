import 'package:flutter/material.dart';
import './messagesList.dart';


class MessagesWidget extends StatelessWidget {
  final List<MessagesWidget> messages;
  final VoidCallback onRefresh;

  MessagesWidget({required this.messages, required this.onRefresh});

  get sender => null;

  get date => null;

  get body => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: onRefresh,
        child: const Icon(Icons.refresh),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int i) {
            var message = messages[i];

            return MessagesListItemWidget(
              sender: message.sender,
              date: message.date,
              body: message.body,
            );
          },
        ),
      ),
      );

  }
}

