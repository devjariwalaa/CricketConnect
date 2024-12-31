import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> messages;

  const MessagesScreen({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return ListView.separated(
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: messages[index]['isUserMessage']
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(
                        messages[index]['isUserMessage'] ? 0 : 20),
                    topLeft: Radius.circular(
                        messages[index]['isUserMessage'] ? 20 : 0),
                  ),
                  color: messages[index]['isUserMessage']
                      ? Colors.grey.shade800
                      : Colors.grey.shade900.withOpacity(0.8),
                ),
                constraints: BoxConstraints(maxWidth: w * 2 / 3),
                child: Text(messages[index]['message']),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, i) => const Padding(padding: EdgeInsets.only(top: 10)),
      itemCount: messages.length,
    );
  }
}