import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_firebase/constants/colors.dart';
import 'package:flutter_ecommerce_app_firebase/services/FirebaseRepository.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final int cartCount;
  final bool hasBackArrow;
  final bool hasBackground;
  final bool hasTitle;

  CustomActionBar(
      {Key key,
      this.title,
      this.cartCount,
      this.hasBackArrow,
      this.hasTitle,
      this.hasBackground})
      : super(key: key);

  FirebaseRepository repository = new FirebaseRepository();

  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('Users');

  final User _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    String _title = title ?? '';
    int _cartCount = cartCount ?? 0;
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasBackground = hasBackground ?? false;
    bool _hasTitle = hasTitle ?? false;

    return Container(
      decoration: BoxDecoration(
          gradient: _hasBackground
              ? LinearGradient(
                  colors: [Colors.white, Colors.white.withOpacity(0.0)],
                  begin: Alignment(0, 0),
                  end: Alignment(0, 1))
              : null),
      padding:
          EdgeInsets.only(top: 56.0, left: 24.0, right: 24.0, bottom: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            GestureDetector(
              child: Container(
                height: 42.0,
                width: 42.0,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0)),
                alignment: Alignment.center,
                child: Image(
                  width: 16.0,
                  height: 16.0,
                  image: AssetImage('assets/images/back_arrow.png'),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          if (_hasTitle)
            Text(
              _title,
              style: boldHeading,
            ),
          Container(
            height: 42.0,
            width: 42.0,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(8.0)),
            alignment: Alignment.center,
            child: StreamBuilder<QuerySnapshot>(
                stream: _usersRef
                    .doc(repository.getUserId())
                    .collection('Cart')
                    .snapshots(),
                builder: (context, snapshot) {
                  int _totalItems = 0;
                  if (snapshot.connectionState == ConnectionState.active) {
                    List _documents = snapshot.data.docs;
                    _totalItems = _documents.length;
                  }
                  return Text(
                    '$_totalItems' ?? '0',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  );
                }),
          )
        ],
      ),
    );
  }
}
