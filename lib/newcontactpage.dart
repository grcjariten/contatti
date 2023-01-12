import 'package:cloud_firestore/cloud_firestore.dart';
import 'functions.dart';
import 'package:flutter/material.dart';

class NewContactPage extends StatefulWidget {
  const NewContactPage({Key? key, required this.db}) : super(key: key);

  final FirebaseFirestore db;
  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        centerTitle: true,
        title: Text(
          "New Contact",
          style: contactStyle(),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Container(
              color: Colors.blueGrey,
              child: Column(
                children: [
                  contactField("name"),
                  contactField("lastName"),
                  contactField("numbah"),
                  saveButton(widget.db, _formKey, context)
                ],
              ),
            ),
          )),
    );
  }
}
