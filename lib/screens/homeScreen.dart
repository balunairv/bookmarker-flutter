import 'package:bookmarker/screens/allGroupsScreen.dart';

import 'package:bookmarker/screens/folderScreen.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.user}) : super(key: key);
  final user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final screens = [const FolderScreen(), AllGroupsScreen()];
  @override
  Widget build(BuildContext context) {
    String uuid = widget.user.uid.toString();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bookmarker'),
        ),
        body: screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() {
            _currentIndex = index;
          }),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Groups')
          ],
        ));
  }
}


// iconSize: 25,
          // currentIndex: _currentIndex,
          // items: const [
          //   BottomNavigationBarItem(
          //     icon: Icon(Icons.home_filled),
          //     label: 'My Bookmarks',
          //   ),
          //   BottomNavigationBarItem(
          //       icon: Icon(Icons.group_rounded), label: 'Groups')
          // ],
          // onTap: (index) {
          //   setState(() {
          //     _currentIndex = index;
          //   });
          // },