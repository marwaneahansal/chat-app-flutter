import 'package:cloud_firestore/cloud_firestore.dart';

class DbMethods {
  getUserByUsername(String username) async {
    return await Firestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .getDocuments();
  }

  uploadUserInfo(userData) {
    Firestore.instance.collection('users').add(userData);
  }
}
