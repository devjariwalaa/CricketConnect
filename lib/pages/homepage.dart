import 'package:crickett_connect/components/bottom_nav.dart';
import 'package:crickett_connect/components/my_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/search_bar.dart';
import '../components/messages.dart'; // Import MessagesScreen
import '../services/dialogflow_service.dart'; // Import DialogflowService

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final DialogflowService _dialogflowService = DialogflowService(); // Initialize DialogflowService
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = []; // List to hold the messages

  @override
  void initState() {
    super.initState();
    _dialogflowService.init(); // Initialize Dialogflow
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void sendMessage(String text) async {
    if (text.isNotEmpty) {
      setState(() {
        messages.add({'message': text, 'isUserMessage': true}); // Add user message
      });

      // Get Dialogflow response
      String response = await _dialogflowService.getResponse(text);
      setState(() {
        messages.add({'message': response, 'isUserMessage': false}); // Add bot response
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
                  "CricketConnect",
                  style: TextStyle(
                    fontSize: 23, // Adjust this value to change the text size
                    fontWeight: FontWeight.bold,
                  ),
                ),
        backgroundColor: const Color.fromARGB(255, 39, 39, 39),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings page or perform action
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Show user account info
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("User Info"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          FirebaseAuth.instance.currentUser?.displayName ?? 'Guest',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(FirebaseAuth.instance.currentUser?.email ?? 'Not signed in'),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: signUserOut,
          ),
        ],
      ),

      drawer: MyDrawer(),
      bottomNavigationBar: BottomNav(),
      body: Column(
        children: [
          Expanded(
            child: MessagesScreen(messages: messages), // Display messages here
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0), // Adjust spacing as needed
            child: AICustomSearchBar(
              controller: _controller,
              onSendMessage: sendMessage, // Pass the sendMessage function
            ),
          ),
        ],
      ),
    );
  }
}