import 'package:flutter/material.dart';
import 'functions.dart';
import 'newcontactpage.dart';
import 'objects.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: HomePage()));
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  FirebaseFirestore db = FirebaseFirestore.instance;

  List<Contact> contactList = [
    Contact("Gianmarco", "David", '3274908591'),
    Contact("Filippo", "Trippiedi", '3274908592'),
    Contact("Samuele", "Nigrelli", '3274908593'),
  ];
  List<Contact> contacts = [];
  @override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.black87,
      body: Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child:
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("rubrica").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) =>
              buildList(context, snapshot)

          )
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text("+"),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NewContactPage(db: db)));
        },
      ),
    );
  }
}


