import 'package:bookmarker/screens/addingScreen.dart';
import 'package:bookmarker/screens/foldersScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:lottie/lottie.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future getBookmarks() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection("users")
        .doc(widget.user.uid)
        .collection("Other")
        .get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark App'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            getBookmarks();
          });
        },
        child: FutureBuilder(
            future: getBookmarks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 241, 92, 81),
                ));
              } else if (!snapshot.hasData) {
                return Center(
                  child: Lottie.network(
                      'https://assets7.lottiefiles.com/datafiles/SkdS7QDyJTKTdwA/data.json'),
                );
              } else {
                var myList = snapshot.data! as List<QueryDocumentSnapshot>;
                return ListView.builder(
                    itemCount: myList.length,
                    itemBuilder: (context, index) {
                      String titleText = myList[index]['title'].toString();
                      // snapshot.hasData ? myList[index]['Other'] : "Error";
                      return Padding(
                        padding: EdgeInsets.all(5),
                        child: ListTile(
                          title: Text(titleText),
                          trailing:
                              const Icon(Icons.arrow_circle_right_rounded),
                          leading: const Icon(Icons.link_rounded),
                          tileColor: Color.fromARGB(255, 176, 250, 178),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => FolderScreen()),
                                ));
                          },
                        ),
                      );
                    });
              }
            }),
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SignOutButton(),
              ListTile(
                leading: const Icon(Icons.verified_user),
                title: const Text("Profile"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const ProfileScreen())));
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          String userId = widget.user.uid.toString();
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => AddingScreen(uid: userId))));
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
