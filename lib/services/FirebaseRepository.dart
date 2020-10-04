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

  // final CollectionReference cartRef =
  // FirebaseFirestore.instance.collection('Users').doc(auth.currentUser.uid).collection('Cart');

  String getUserId() => auth.currentUser.uid;

  CollectionReference getCartCollectionRef() {
    return usersRef.doc(auth.currentUser.uid).collection('Cart');
  }

  void signOut() => auth.signOut();
}
