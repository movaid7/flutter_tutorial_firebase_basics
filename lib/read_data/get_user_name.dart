import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String docID;
  const GetUserName({Key? key, required this.docID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(docID).get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
              "${data['firstName']} ${data['lastName']},  ${data['age']} years old");
        }

        return const Text("loading");
      },
    );
  }
}
