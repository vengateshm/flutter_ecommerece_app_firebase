import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_firebase/constants/colors.dart';
import 'package:flutter_ecommerce_app_firebase/screens/register_screen.dart';
import 'package:flutter_ecommerce_app_firebase/widgets/custom_button.dart';
import 'package:flutter_ecommerce_app_firebase/widgets/custom_input.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Text(
                  'Welcome User,\nLogin to your account',
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
                    text: 'Login',
                    isOutlined: false,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: CustomButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RegisterScreen()));
                  },
                  text: 'Create New Account',
                  isOutlined: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
