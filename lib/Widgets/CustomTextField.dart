import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData iconText;
  final Function onClick;
  CustomTextField(
      {@required this.hintText,
      @required this.iconText,
      @required this.onClick});

  // ignore: missing_return
  String messageError(String str) {
    switch (str) {
      case 'Enter Your Name':
        return 'Name is Empty';
      case 'Enter Your email':
        return 'email is Empty';
      case 'Enter Your Password':
        return 'Password is Empty';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: TextFormField(
        // ignore: missing_return
        validator: (value) {
          if (value.isEmpty) {
            return messageError(hintText);
          }
        },
        onSaved: onClick,
        // keyboardType: hintText == 'Enter Your email'
        //     ? TextInputType.emailAddress
        //     : TextInputType.values,
        obscureText: hintText == 'Enter Your Password' ? true : false,
        cursorColor: Colors.yellow,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(iconText),
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
