import 'package:flutter/material.dart';

class AICustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSendMessage;

  const AICustomSearchBar({super.key, required this.controller, required this.onSendMessage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Send a message',
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send, color: Colors.black),
                  onPressed: () {
                    onSendMessage(controller.text); // Call the sendMessage function
                    controller.clear(); // Clear the text field after sending
                  },
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}