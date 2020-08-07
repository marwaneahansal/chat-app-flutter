import 'package:cloud_firestore/cloud_firestore.dart';

class DbMethods {
  getUserByUsername(String username) async {
    return await Firestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .getDocuments();
  }

  getUserByEmail(String email) async {
    return await Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments();
  }

  uploadUserInfo(userData) {
    Firestore.instance.collection('users').add(userData);
  }

  createConversation(chatUsers) {
    Firestore.instance.collection("Conversation").document().setData(chatUsers);
  }
}
