import 'package:flutter/material.dart';

class AllGroupsScreen extends StatefulWidget {
  AllGroupsScreen({Key? key}) : super(key: key);

  @override
  State<AllGroupsScreen> createState() => _AllGroupsScreenState();
}

class _AllGroupsScreenState extends State<AllGroupsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Groups'),
    );
  }
}
