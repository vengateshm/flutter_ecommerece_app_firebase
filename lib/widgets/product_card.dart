import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_firebase/constants/colors.dart';
import 'package:flutter_ecommerce_app_firebase/screens/product_screen.dart';

class ProductCard extends StatelessWidget {
  final String productId;
  final Function onPressed;
  final String imgURL;
  final String price;
  final String title;

  ProductCard(
      {this.onPressed, this.imgURL, this.price, this.productId, this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        height: 350,
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
        margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Stack(
          children: [
            Container(
              height: 350,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  imgURL,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title ?? 'Product Name',
                      style: regularHeading,
                    ),
                    Text(
                      price ?? 'Price',
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
