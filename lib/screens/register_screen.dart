import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_firebase/constants/colors.dart';
import 'package:flutter_ecommerce_app_firebase/widgets/custom_button.dart';
import 'package:flutter_ecommerce_app_firebase/widgets/custom_input.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Text(
                'Create A New Account',
                textAlign: TextAlign.center,
                style: boldHeading,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(
                  hintText: 'Email',
                ),
                CustomTextField(
                  hintText: 'Password',
                ),
                CustomButton(
                  onPressed: () {},
                  text: 'Create Account',
                  isOutlined: false,
                ),
              ],
            ),
            CustomButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              text: 'Back To Login',
              isOutlined: true,
            ),
          ],
        ),
      ),
    );
  }
}
