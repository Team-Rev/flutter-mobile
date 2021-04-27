import 'package:flutter/material.dart';

import 'color_rev.dart';

class ReUsable {
  static TextButton buildTextButton2(String text, onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
      style: ColorRev.buttonStyle1,
    );
  }

  //투명버튼
  static TextButton buildTextButton3(String text, onPressed, {style}) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text, style: style,),
      style: ColorRev.buttonStyle2,
    );
  }

  TextButton buildTextButton(Text, Color color, Color fontColor,
      {onPressed, padding}) {
    return TextButton(
      onPressed: onPressed,
      child: Text,
      style: TextButton.styleFrom(
          primary: fontColor, backgroundColor: color, padding: padding),
    );
  }


  static TextFormField buildTextFormField(TextEditingController controller,
      Icon icon, String labelText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        icon: icon,
        labelText: labelText,
        errorStyle: TextStyle(color: ColorRev.red, fontWeight: FontWeight.bold),
      ),
      validator: (text) {
        if (text == null || text.isEmpty) return 'Please input correctly';
        return null;
      },
    );
  }
}