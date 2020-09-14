import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_firebase/widgets/custom_action_bar.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _productsCollectionRef =
      FirebaseFirestore.instance.collection('Products');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
              future: _productsCollectionRef.get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }

                // Product collection data
                if (snapshot.connectionState == ConnectionState.done) {
                  // Display data in list view
                  return ListView(
                    padding: EdgeInsets.only(top: 108, bottom: 12.0),
                    children: snapshot.data.docs
                        .map((document) => Container(
                              height: 350,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0)),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 12.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.network(
                                  document.data()['images'][0],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ))
                        .toList(growable: true),
                  );
                }

                // Loading state
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
          CustomActionBar(
            title: 'Home',
            hasTitle: true,
            hasBackArrow: false,
          )
        ],
      ),
    );
  }
}