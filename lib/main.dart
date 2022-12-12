import 'package:flutter/material.dart';
import 'functions.dart';
import 'newcontactpage.dart';
import 'objects.dart';

void main() {
  runApp(MaterialApp(home: HomePage()));
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  List<Contact> contactList = [
    Contact("Gianmarco", "David", '3274908591'),
    Contact("Filippo", "Trippiedi", '3274908592'),
    Contact("Samuele", "Nigrelli", '3274908593'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: ListView.builder(
          itemCount: contactList.length,
          itemBuilder: (context, index) {
            Contact contact = contactList[index];
            return GestureDetector(
              onTap: () {
                showNumber(context, contact.number);
              },
              child: ListTile(
                leading: CircleAvatar(child: Text(contact.name[0])),
                title: Text(
                  "${contact.name} ${contact.lastName}",
                  style: contactStyle(),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text("+"),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NewContactPage()));
        },
      ),
    );
  }
}
