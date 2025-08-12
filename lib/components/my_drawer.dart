import 'package:flutter/material.dart';
import 'package:crickett_connect/services/firestore_service.dart';
import 'chat_model.dart';

class MyDrawer extends StatelessWidget {
  final String userId; // Pass the logged-in user's ID

  const MyDrawer({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();

    return Drawer(
      child: Column(
        children: [
          // Use SafeArea to avoid being hidden behind the dynamic island or status bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  "History",
                  style: TextStyle(
                    fontSize: 24, // Customize the text size
                    fontWeight: FontWeight.bold, // Customize text style
                  ),
                ),
              ),
            ),
          ),
          // StreamBuilder to display chat history
          Expanded(
            child: StreamBuilder<List<ChatMessage>>(
              stream: firestoreService.getChatHistory(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No chat history available."));
                }

                final chatHistory = snapshot.data!;

                return ListView.builder(
                  itemCount: chatHistory.length,
                  itemBuilder: (context, index) {
                    final chat = chatHistory[index];
                    return ListTile(
                      title: Text(chat.message),
                      subtitle: Text("${chat.sender} - ${chat.timestamp}"),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}