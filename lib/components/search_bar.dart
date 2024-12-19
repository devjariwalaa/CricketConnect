import 'package:flutter/material.dart';

// Assuming you already have this AI search bar widget.
// Here's an example structure for the AI search bar that you had implemented.
class AICustomSearchBar extends StatelessWidget {
  final TextEditingController controller;

  AICustomSearchBar({super.key})
      : controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: Icon(Icons.search, color: Colors.black),
          suffixIcon: Icon(Icons.mic, color: Colors.black), // Example AI button
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        ),
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
