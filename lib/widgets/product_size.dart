import 'package:flutter/material.dart';

class ProductSize extends StatefulWidget {
  final List productSizeList;
  final Function(String) onSelected;

  ProductSize({this.productSizeList, this.onSelected});

  @override
  _ProductSizeState createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Row(
        children: [
          for (var i = 0; i < widget.productSizeList.length; i++)
            GestureDetector(
              onTap: () {
                setState(() {
                  _selected = i;
                  widget.onSelected('${widget.productSizeList[i]}');
                });
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: _selected == i
                        ? Theme.of(context).accentColor
                        : Color(0xffdcdcdc),
                    borderRadius: BorderRadius.circular(8.0)),
                child: Text(
                  '${widget.productSizeList[i]}',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: _selected == i ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )
        ],
      ),
    );
  }
}
