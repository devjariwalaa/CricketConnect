import 'package:crickett_connect/components/bottom_nav.dart';
import 'package:crickett_connect/components/my_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/search_bar.dart';
import '../components/messages.dart'; // Import MessagesScreen
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = []; // List to hold the messages

  @override
  void initState() {
    super.initState();
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<void> sendMessage(String text) async {
    if (text.isNotEmpty) {
      setState(() {
        messages.add({'message': text, 'isUserMessage': true}); // Add user message
      });

      try {
        // Call your Flask API
        final response = await _getResponseFromFlask(text);
        setState(() {
          messages.add({'message': response, 'isUserMessage': false}); // Add bot response
        });
      } catch (e) {
        setState(() {
          messages.add({'message': 'An error occurred, please try again.', 'isUserMessage': false});
        });
      }
    }
  }

  // Function to send request to Flask API
  Future<String> _getResponseFromFlask(String question) async {
    final url = Uri.parse('http://127.0.0.1:5000/ask'); // Flask API URL
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'question': question});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['response']; // The LLaMA response
      } else {
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    final String userId = FirebaseAuth.instance.currentUser?.uid ?? ''; // Retrieve userId

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

      drawer: MyDrawer(
        userId: userId, // Pass the userId to the drawer
      ),
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