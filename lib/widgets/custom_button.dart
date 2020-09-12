import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isOutlined;
  final bool isLoading;

  const CustomButton(
      {Key key, this.onPressed, this.isOutlined, this.isLoading, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _isLoading = isLoading?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 65.0,
        margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isOutlined ? Colors.transparent : Colors.black,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.black, width: 2.0),
        ),
        child: Stack(
          children: [
            Visibility(
                visible: _isLoading ? false : true,
                child: Center(
                  child: Text(
                    text ?? "",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: isOutlined ? Colors.black : Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )),
            Visibility(
                visible: _isLoading ? true : false,
                child: Center(
                  child: SizedBox(
                      width: 30.0,
                      height: 30.0,
                      child: CircularProgressIndicator()),
                ))
          ],
        ),
      ),
    );
  }
}
