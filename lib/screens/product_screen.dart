import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_firebase/constants/colors.dart';
import 'package:flutter_ecommerce_app_firebase/services/FirebaseRepository.dart';
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
  FirebaseRepository repository = new FirebaseRepository();

  Future _addToCart() {
    return repository.usersRef
        .doc(repository.getUserId())
        .collection('Cart')
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }

  final SnackBar _snackBar =
      SnackBar(content: Text('Product added to the cart'));

  String _selectedProductSize = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<DocumentSnapshot>(
              future: repository.productsRef.doc(widget.productId).get(),
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
                  // Firestore document map data
                  Map<String, dynamic> documentData = snapshot.data.data();
                  List images = documentData['images'];
                  List size = documentData['size'];

                  _selectedProductSize = size[0];

                  return ListView(
                    children: [
                      HorizontalSwipeableImage(imageList: images),
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
                        productSizeList: size,
                        onSelected: (selectedSize) {
                          _selectedProductSize = selectedSize;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24.0, horizontal: 24.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffdcdcdc),
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: Image(
                                image:
                                    AssetImage('assets/images/tab_saved.png'),
                                height: 22.0,
                              ),
                              height: 65.0,
                              width: 65.0,
                              alignment: Alignment.center,
                            ),
                            Expanded(
                              child: GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  child: Text(
                                    'Add To Cart',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0),
                                  ),
                                  height: 65.0,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(left: 16.0),
                                ),
                                onTap: () async {
                                  await _addToCart();
                                  Scaffold.of(context).showSnackBar(_snackBar);
                                },
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
