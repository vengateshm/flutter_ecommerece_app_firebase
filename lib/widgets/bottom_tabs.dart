import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabPressPosition;

  BottomTabs({this.selectedTab, this.tabPressPosition});

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 0;

  @override
  void initState() {
    _selectedTab = widget.selectedTab;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 30.0,
                spreadRadius: 1.0)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabButton(
            imageURI: 'assets/images/tab_home.png',
            isSelected: _selectedTab == 0 ? true : false,
            onPressed: () {
              setState(() {
                widget.tabPressPosition(0);
              });
            },
          ),
          BottomTabButton(
            imageURI: 'assets/images/tab_search.png',
            isSelected: _selectedTab == 1 ? true : false,
            onPressed: () {
              setState(() {
                widget.tabPressPosition(1);
              });
            },
          ),
          BottomTabButton(
            imageURI: 'assets/images/tab_saved.png',
            isSelected: _selectedTab == 2 ? true : false,
            onPressed: () {
              setState(() {
                widget.tabPressPosition(2);
              });
              ;
            },
          ),
          BottomTabButton(
            imageURI: 'assets/images/tab_logout.png',
            isSelected: _selectedTab == 3 ? true : false,
            onPressed: () {
              setState(() {
                widget.tabPressPosition(3);
              });
            },
          ),
        ],
      ),
    );
  }
}

class BottomTabButton extends StatelessWidget {
  final String imageURI;
  final bool isSelected;
  final Function onPressed;

  const BottomTabButton({
    Key key,
    this.imageURI,
    this.isSelected,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isSelected = isSelected ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: _isSelected
                        ? Theme.of(context).accentColor
                        : Colors.transparent,
                    width: 2.0))),
        padding: EdgeInsets.symmetric(vertical: 28.0, horizontal: 24.0),
        child: Image(
          color: _isSelected ? Theme.of(context).accentColor : Colors.black,
          width: 22.0,
          height: 22.0,
          image: AssetImage(imageURI),
        ),
      ),
    );
  }
}
