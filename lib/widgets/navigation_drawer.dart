import 'package:firebase_basics/auth/main_page.dart';
import 'package:firebase_basics/pages/edit_profile.dart';
import 'package:flutter/material.dart';

class MyNavigationDrawer extends StatelessWidget {
  const MyNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHeader(context),
          buildMenuItems(context),
        ],
      ),
    );
  }
}

Widget buildHeader(BuildContext context) {
  return SizedBox(
    height: 120,
    child: DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: const BoxDecoration(color: Colors.deepPurple),
        child: Stack(children: const <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Welcome to Flutter",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ])),
  );
}

Widget buildMenuItems(BuildContext context) {
  return Expanded(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MainPage()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Edit Profile'),
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const EditProfile()));
          },
        ),
      ],
    ),
  );
}
