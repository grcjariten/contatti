import 'package:flutter/material.dart';

Future<dynamic> showNumber(BuildContext context, String number) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(number),
        );
      });
}

TextStyle contactStyle() {
  return const TextStyle(color: Colors.white);
}
