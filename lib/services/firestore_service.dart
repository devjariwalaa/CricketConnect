import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crickett_connect/components/chat_model.dart';

class FirestoreService {
  Stream<List<ChatMessage>> getChatHistory(String userId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .limit(50)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => ChatMessage.fromMap(doc.data()))
              .toList();
        });
  }
}