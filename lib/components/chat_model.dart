import 'package:cloud_firestore/cloud_firestore.dart'; // For Firestore Timestamp

class ChatMessage {
  final String message; // The chat message content
  final String sender;  // Sender of the message ("User" or "Bot")
  final DateTime timestamp; // Time when the message was sent

  // Constructor to initialize a chat message
  ChatMessage({
    required this.message,
    required this.sender,
    required this.timestamp,
  });

  // Convert the ChatMessage object into a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'sender': sender,
      'timestamp': timestamp,
    };
  }

  // Factory constructor to create a ChatMessage object from a Firestore Map
  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      message: map['message'] ?? '', // Default to empty string if null
      sender: map['sender'] ?? 'Unknown', // Default to "Unknown" if null
      timestamp: (map['timestamp'] as Timestamp).toDate(), // Convert Firestore Timestamp to DateTime
    );
  }
}