import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_basics/read_data/get_user_name.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // doc IDs
  List<String> docIDs = [];

  // get all doc IDs
  Future getDocIDs() async {
    docIDs = [];
    final user = FirebaseAuth.instance.currentUser;
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {
      for (var element in value.docs) {
        docIDs.add(element.id);
      }
      print(docIDs);
    });
  }

  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${user.email}',
            style: const TextStyle(color: Colors.white, fontSize: 16)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              child: const Icon(Icons.logout_outlined),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: FutureBuilder(
                  future: getDocIDs(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                        itemCount: docIDs.length,
                        itemBuilder: (context, index) {
                          // fetch first name for each doc ID

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: GetUserName(docID: docIDs[index]),
                              tileColor: Colors.grey[200],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
