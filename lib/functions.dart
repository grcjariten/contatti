import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

TextFormField contactField(String data) {
  return TextFormField(
    decoration: InputDecoration(hintText: data),
    inputFormatters:
        data == "numbah" ? [FilteringTextInputFormatter.digitsOnly] : null,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Cazzo fai, riempi';
      }
      return null; //vuol dire che funge
    },
  );
}

ElevatedButton saveButton(GlobalKey<FormState> formKey, BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      if (formKey.currentState!.validate()) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Contact Saved!")));
      }
    },
    child: Text(
      "Save",
      style: contactStyle(),
    ),
  );
}
