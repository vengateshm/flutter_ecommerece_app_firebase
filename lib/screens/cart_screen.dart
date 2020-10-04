import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_firebase/screens/product_screen.dart';
import 'package:flutter_ecommerce_app_firebase/services/FirebaseRepository.dart';
import 'package:flutter_ecommerce_app_firebase/widgets/custom_action_bar.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  FirebaseRepository repository = FirebaseRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder<QuerySnapshot>(
                future: repository.getCartCollectionRef().get(),
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
                          .map((document) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailScreen(
                                                productId: document.id,
                                              )));
                                },
                                child: FutureBuilder<DocumentSnapshot>(
                                  future: repository.productsRef
                                      .doc(document.id)
                                      .get(),
                                  builder: (context, productSnapshot) {
                                    if (productSnapshot.hasError) {
                                      return Container(
                                        child: Center(
                                          child: Text(
                                              "Error: ${productSnapshot.error}"),
                                        ),
                                      );
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      Map productMap =
                                          productSnapshot.data.data();
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16.0, horizontal: 24.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 90,
                                              height: 90,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  productMap['images'][0],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 16.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    productMap['name'],
                                                    style: TextStyle(
                                                        fontSize: 18.0,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 4.0),
                                                    child: Text(
                                                      '\$${productMap['price']}',
                                                      style: TextStyle(
                                                          fontSize: 16.0,
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Text('Size - ${document.data()['size']}',style: TextStyle(
                                                      fontSize: 16.0,
                                                      color:
                                                      Colors.black,
                                                      fontWeight:
                                                      FontWeight.w600),)
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                    return Scaffold(
                                      body: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  },
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
              title: 'Cart',
              hasBackArrow: true,
              hasTitle: true,
              cartCount: 4,
            )
          ],
        ),
      ),
    );
  }
}
