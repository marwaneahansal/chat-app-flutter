import 'package:cloud_firestore/cloud_firestore.dart';

class DbMethods {
  getUserByEail(String userEmail) {}

  uploadUserInfo(userData) {
    Firestore.instance.collection('users').add(userData);
  }
}
