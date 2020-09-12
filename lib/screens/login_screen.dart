import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_firebase/constants/colors.dart';
import 'package:flutter_ecommerce_app_firebase/screens/register_screen.dart';
import 'package:flutter_ecommerce_app_firebase/utils/alert_dialog_util.dart';
import 'package:flutter_ecommerce_app_firebase/widgets/custom_button.dart';
import 'package:flutter_ecommerce_app_firebase/widgets/custom_input.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';
  bool _isLoading = false;
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode?.dispose();
    super.dispose();
  }

  Future<String> _login() async {
    String result = '';
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        result = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        result = 'Wrong password provided for that user.';
      }
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

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
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      _email = value;
                    },
                    onSubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                  ),
                  CustomTextField(
                    isPasswordField: true,
                    hintText: 'Password',
                    onChanged: (value) {
                      _password = value;
                    },
                    focusNode: _passwordFocusNode,
                  ),
                  CustomButton(
                    onPressed: () {
                      onLoginButtonPressed();
                    },
                    text: 'Login',
                    isOutlined: false,
                    isLoading: _isLoading,
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

  void onLoginButtonPressed() async {
    setState(() {
      _isLoading = true;
    });

    String loginResult = await _login();
    if (loginResult.isNotEmpty) {
      // Error occurred during login
      alertDialogBuilder(context, 'Error', loginResult, () {
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
      });
    } else {
      // Go back to login screen
      Navigator.pop(context);
    }
  }
}
