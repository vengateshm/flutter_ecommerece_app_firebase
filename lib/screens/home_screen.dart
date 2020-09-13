import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_firebase/tabs/home_tab.dart';
import 'package:flutter_ecommerce_app_firebase/tabs/saved_tab.dart';
import 'package:flutter_ecommerce_app_firebase/tabs/search_tab.dart';
import 'package:flutter_ecommerce_app_firebase/widgets/bottom_tabs.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _tabsPageController;
  int _currentPage = 0;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                child: PageView(
                  controller: _tabsPageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  children: [HomeTab(), SearchTab(), SavedTab()],
                ),
              ),
            ),
            BottomTabs(
              selectedTab: _currentPage,
              tabPressPosition: (position) {
                _tabsPageController.animateToPage(position,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic);
              },
            )
          ],
        ),
      ),
    );
  }
}
