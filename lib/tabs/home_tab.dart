import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_firebase/widgets/custom_action_bar.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
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
