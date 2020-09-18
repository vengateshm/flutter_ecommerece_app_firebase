import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_firebase/constants/colors.dart';
import 'package:flutter_ecommerce_app_firebase/widgets/custom_action_bar.dart';
import 'package:flutter_ecommerce_app_firebase/widgets/horizontal_swipeable_image.dart';
import 'package:flutter_ecommerce_app_firebase/widgets/product_size.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  ProductDetailScreen({this.productId});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection('Products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<DocumentSnapshot>(
              future: _productsRef.doc(widget.productId).get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }

                // Once product document is fetched
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView(
                    children: [
                      HorizontalSwipeableImage(
                          imageList: snapshot.data.data()['images']),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 24.0),
                        child: Text(
                          snapshot.data.data()['name'],
                          style: boldHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 24.0),
                        child: Text(
                          '\$${snapshot.data.data()['price']}',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 24.0),
                        child: Text(
                          snapshot.data.data()['desc'],
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 24.0),
                        child: Text(
                          'Select Size',
                          style: regularHeading,
                        ),
                      ),
                      ProductSize(
                          productSizeList: snapshot.data.data()['size']),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24.0, horizontal: 24.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color:Color(0xffdcdcdc),
                                borderRadius: BorderRadius.circular(12.0)
                              ),
                              child: Image(
                                image: AssetImage('assets/images/tab_saved.png'),

                                height: 22.0,
                              ),
                              height: 65.0,
                              width: 65.0,
                              alignment: Alignment.center,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color:Colors.black,
                                    borderRadius: BorderRadius.circular(12.0)
                                ),
                                child: Text('Add To Cart',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0
                                ),),
                                height: 65.0,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: 16.0),
                              ),
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.start,
                        ),
                      )
                    ],
                  );
                }

                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
          CustomActionBar(
            hasTitle: false,
            hasBackArrow: true,
            hasBackground: false,
          )
        ],
      ),
    );
  }
}
