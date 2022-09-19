import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_basics/auth/main_page.dart';
import 'package:firebase_basics/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:number_selector/number_selector.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // controllers for the text fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String _emailAddress = '';

  // update profile function
  Future updateProfile() async {
    // check if the fields are valid
    if (_firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _ageController.text.isNotEmpty &&
        int.tryParse(_ageController.text) != null) {
      // get the current user
      User? user = FirebaseAuth.instance.currentUser;

      // update the user's profile
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'age': int.tryParse(_ageController.text) ?? 0,
      }).then((value) => print("Profile Updated"));

      // show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile Updated', textAlign: TextAlign.center),
        ),
      );

      // Go to the main page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    }
    // else show a snackbar
    else if (_ageController.text.isNotEmpty &&
        int.tryParse(_ageController.text) == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Age must be a number', textAlign: TextAlign.center),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all the fields',
              textAlign: TextAlign.center),
        ),
      );
    }
  }

  // load the user's profile data on page load
  setUserProfile() async {
    // get the current user
    User? user = FirebaseAuth.instance.currentUser;

    // get the user's profile data
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // set the text fields to the user's profile data
        _firstNameController.text = documentSnapshot['firstName'];
        _lastNameController.text = documentSnapshot['lastName'];
        _ageController.text = documentSnapshot['age'].toString();
        _emailAddress = documentSnapshot['email'];
      }
    });
  }

  @override
  initState() {
    super.initState();
    setUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      drawer: const NavigationDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                _emailAddress,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            const Text('Edit First Name', style: TextStyle(fontSize: 14.0)),
            TextField(controller: _firstNameController),

            const SizedBox(height: 24.0),
            const Text('Edit Last Name', style: TextStyle(fontSize: 14.0)),
            TextField(controller: _lastNameController),

            const SizedBox(height: 24.0),
            const Text('Edit Age', style: TextStyle(fontSize: 14.0)),
            Center(
              child: NumberSelector(
                height: 50,
                width: 180,
                current: int.parse(_ageController.text),
                backgroundColor: Colors.transparent,
                incrementIcon: Icons.add,
                decrementIcon: Icons.remove,
                showSuffix: false,
                hasBorder: false,
                hasDividers: false,
                hasCenteredText: true,
                onUpdate: (val) {
                  _ageController.text = val.toString();
                },
              ),
            ),
            const SizedBox(height: 16.0),
            // update profile button
            Center(
              child: ElevatedButton(
                onPressed: updateProfile,
                child: const Text('Update Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
