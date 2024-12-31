import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save message to Firestore
  Future<void> saveMessage(String userId, String message) async {
    try {
      await _db.collection('chat_history').add({
        'user_id': userId,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print("Message saved to Firestore");
    } catch (e) {
      print("Error saving message to Firestore: $e");
    }
  }

  // Retrieve chat history from Firestore
  Stream<QuerySnapshot> getChatHistory(String userId) {
    return _db
        .collection('chat_history')
        .where('user_id', isEqualTo: userId)
        .orderBy('timestamp', descending: false) // Order by timestamp
        .snapshots(); // Real-time updates
  }
}