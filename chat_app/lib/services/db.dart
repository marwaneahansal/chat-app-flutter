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

  addConversationMessages(String conversationId, messages) async {
    QuerySnapshot myCollection = await Firestore.instance
        .collection('Conversation')
        .where("conversationId", isEqualTo: conversationId)
        .getDocuments();
    // Firestore.instance
    //     .collection(myCollection)
    //     .document()
    //     .collection('chatMessages')
    //     .add(messages);
    // .collection("chatMessages")
    // .add(messages);
    String documentId = myCollection.documents[0].documentID;
    Firestore.instance
        .collection('Conversation')
        .document(documentId)
        .collection('chatMessages')
        .add(messages)
        .catchError((err) => print("Chat messages errro: ${err.toString()}"));
  }

  getConversationMessages(String conversationId) async {
    QuerySnapshot myCollection = await Firestore.instance
        .collection('Conversation')
        .where("conversationId", isEqualTo: conversationId)
        .getDocuments();

    String documentId = myCollection.documents[0].documentID;
    return Firestore.instance
        .collection('Conversation')
        .document(documentId)
        .collection('chatMessages')
        .orderBy("createdAt", descending: false)
        .snapshots();
  }
}
