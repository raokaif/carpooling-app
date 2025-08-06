import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String getChatRoomId(String userA, String userB) {
    return userA.hashCode <= userB.hashCode
        ? '$userA\_$userB'
        : '$userB\_$userA';
  }

  Stream<QuerySnapshot> getMessages(String chatRoomId) {
    return _firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> sendMessage({
    required String chatRoomId,
    required String senderId,
    required String receiverId,
    required String message,
  }) async {
    await _firestore.collection('chatRooms').doc(chatRoomId).set({
      'users': [senderId, receiverId],
      'lastMessage': message,
      'lastUpdated': Timestamp.now(),
    });

    await _firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .add({
          'senderId': senderId,
          'receiverId': receiverId,
          'message': message,
          'timestamp': Timestamp.now(),
        });
  }
}
