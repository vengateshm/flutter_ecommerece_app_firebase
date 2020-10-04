import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_firebase/constants/colors.dart';
import 'package:flutter_ecommerce_app_firebase/screens/product_screen.dart';
import 'package:flutter_ecommerce_app_firebase/services/FirebaseRepository.dart';
import 'package:flutter_ecommerce_app_firebase/widgets/custom_action_bar.dart';
import 'package:flutter_ecommerce_app_firebase/widgets/product_card.dart';

class HomeTab extends StatelessWidget {
  FirebaseRepository repository = FirebaseRepository();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
              future: repository.productsRef.get(),
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
                        .map((document) => ProductCard(
                              productId: document.id,
                              title: document.data()['name'],
                              imgURL: '${document.data()['images'][0]}',
                              price: '\$${document.data()['price']}',
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailScreen(
                                              productId: document.id,
                                            )));
                              },
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
