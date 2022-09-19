import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/edit_profile.dart';

class UserTile extends StatelessWidget {
  final String docID;
  const UserTile({Key? key, required this.docID}) : super(key: key);

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
          bool isCurrUser =
              snapshot.data!.id == FirebaseAuth.instance.currentUser!.uid;

          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: GestureDetector(
              onTap: () {
                // open edit page if current user
                isCurrUser
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditProfile()))
                    : null;
              },
              child: ListTile(
                tileColor:
                    isCurrUser ? Colors.deepPurple[100] : Colors.grey[200],
                title: Text(
                    "${data['firstName']} ${data['lastName']},  ${data['age']} years old"),
                trailing: isCurrUser ? const Icon(Icons.person) : null,
              ),
            ),
          );
        }

        return const Text("loading");
      },
    );
  }
}
