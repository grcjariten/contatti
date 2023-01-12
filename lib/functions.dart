import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'objects.dart';

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

ElevatedButton saveButton(
    FirebaseFirestore db, GlobalKey<FormState> formKey, BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      if (formKey.currentState!.validate()) {
        var user = <String, dynamic>{
          "name": "Ada",
          "lastname": "Lovelace",
          "number": 1815
        };
        db.collection("rubrica").add(user).then((DocumentReference doc) =>
            print("DocumentSnapshot added with ID: ${doc.id}"));
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

Future<dynamic> showNumber(BuildContext context, String number) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(number),
        );
      });
}

Future<List<Contact>> getData(FirebaseFirestore db) async {
  List<Contact> data = [];
  await db.collection("rubrica").get().then((event) {
    for (var doc in event.docs) {
      data.add(Contact(
          doc.data()['name'], doc.data()['lastname'], doc.data()['number']));
    }
  });
  return data;
}
