import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalSwipeableImage extends StatefulWidget {
  final List imageList;

  HorizontalSwipeableImage({this.imageList});

  @override
  _HorizontalSwipeableImageState createState() =>
      _HorizontalSwipeableImageState();
}

class _HorizontalSwipeableImageState extends State<HorizontalSwipeableImage> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Stack(
        children: [
          PageView(
              onPageChanged: (pageIndex) {
                setState(() {
                  _selectedPage = pageIndex;
                });
              },
              children: [
                for (var i = 0; i < widget.imageList.length; i++)
                  Container(
                    child: Image.network(
                      '${widget.imageList[i]}',
                      fit: BoxFit.cover,
                    ),
                  )
              ]),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < widget.imageList.length; i++)
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: _selectedPage == i ? 35.0 : 10.0,
                    height: 10.0,
                    curve: Curves.easeOutCubic,
                    margin: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.0)),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
