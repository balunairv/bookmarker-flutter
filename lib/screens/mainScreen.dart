import 'package:bookmarker/screens/addingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark App'),
      ),
      body: Column(
        children: [const SignOutButton(), Text(user.email!)],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const AddingScreen())));
        },
        label: const Text('Create'),
        icon: const Icon(
          Icons.add,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
