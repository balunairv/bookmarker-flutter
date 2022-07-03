import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import 'folderAddingScreen.dart';
import 'bookmarkListScreen.dart';

class FolderScreen extends StatefulWidget {
  const FolderScreen({Key? key, required this.user}) : super(key: key);
  final user;

  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  Stream getFolders() async* {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection("users")
        .doc(widget.user.uid)
        .collection("folders")
        .orderBy('title', descending: false)
        .get();
    yield qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Folders'),
      ),
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            getFolders();
          });
        },
        child: StreamBuilder(
          stream: getFolders(),
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
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: myList.length,
                itemBuilder: (context, index) {
                  String folderName = myList[index]['title'].toString();
                  String iconUrl = myList[index]['iconUrl'].toString();
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookmarkListScreen(
                                  uid: widget.user.uid, folder: folderName),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromARGB(255, 161, 155, 155),
                        ),
                        height: 1000,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Lottie.network(iconUrl, height: 100),
                            Text(
                              folderName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          String userId = widget.user.uid.toString();
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => folderAddingScreen(uid: userId))));
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
