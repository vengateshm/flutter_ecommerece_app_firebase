import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepository {
  FirebaseAuth auth;
  FirebaseFirestore firestore;

  FirebaseRepository() {
    auth = FirebaseAuth.instance;
    firestore = FirebaseFirestore.instance;
  }

  final CollectionReference productsRef =
      FirebaseFirestore.instance.collection('Products');
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('Users');

  String getUserId() => auth.currentUser.uid;

  void signOut() => auth.signOut();
}
