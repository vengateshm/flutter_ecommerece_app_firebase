import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_firebase/constants/colors.dart';
import 'package:flutter_ecommerce_app_firebase/widgets/custom_button.dart';
import 'package:flutter_ecommerce_app_firebase/widgets/custom_input.dart';
import 'package:flutter_ecommerce_app_firebase/utils/alert_dialog_util.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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

  Future<String> _createAccount() async {
    String result = '';
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        result = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        result = 'The account already exists for that email.';
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
                  onChanged: (value) {
                    _email = value;
                  },
                  onSubmitted: (value) {
                    _passwordFocusNode.requestFocus();
                  },
                  hintText: 'Email',
                  textInputAction:
                      TextInputAction.next, // Similar to android IME
                ),
                CustomTextField(
                  focusNode: _passwordFocusNode,
                  isPasswordField: true,
                  onChanged: (value) {
                    _password = value;
                  },
                  hintText: 'Password',
                ),
                CustomButton(
                  onPressed: () {
                    onCreateAccountButtonPressed();
                  },
                  text: 'Create Account',
                  isOutlined: false,
                  isLoading: _isLoading,
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

  void onCreateAccountButtonPressed() async {
    setState(() {
      _isLoading = true;
    });

    String createAccountResult = await _createAccount();
    if (createAccountResult.isNotEmpty) {
      // Error occurred during registration
      alertDialogBuilder(context, 'Error', createAccountResult, () {
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
