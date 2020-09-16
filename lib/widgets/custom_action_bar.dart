import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_firebase/constants/colors.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final int cartCount;
  final bool hasBackArrow;
  final bool hasBackground;
  final bool hasTitle;

  const CustomActionBar(
      {Key key,
      this.title,
      this.cartCount,
      this.hasBackArrow,
      this.hasTitle,
      this.hasBackground})
      : super(key: key);

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
            Container(
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
            child: Text(
              '$_cartCount',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
