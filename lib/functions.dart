import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


TextStyle contactStyle() {
  return const TextStyle(color: Colors.white);
}

TextFormField contactField(String data, TextEditingController controller) {
  return TextFormField(
    controller: controller,
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
    FirebaseFirestore db, GlobalKey<FormState> formKey,
    TextEditingController name, TextEditingController lastname, TextEditingController number,
    BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      if (formKey.currentState!.validate()) {
        var user = <String, dynamic>{
          "name": name.text.toString(),
          "lastname": lastname.text.toString(),
          "number": number.text
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

Widget buildList(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  if(snapshot.connectionState == ConnectionState.waiting) {
    return const Center(child: CircularProgressIndicator(),);
  }
  if(!snapshot.hasData) {
    return const Text("No Data");
  }
  print(snapshot.data!.docs[0]['name'][0]);

  return SingleChildScrollView(
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              showNumber(context, snapshot.data!.docs[index]["number"].toString());
            },
            child: ListTile(
              leading: Text(snapshot.data!.docs[index]['name'][0].toString(), style: const TextStyle(color: Colors.white),),
              title: Text(
                "${snapshot.data!.docs[index]['name'].toString()} "
                    "${snapshot.data!.docs[index]['lastname'].toString()}"
                ,style: const TextStyle(color: Colors.white),
              ),

            ),
          ),
        );
      },
    ),
  );

}


