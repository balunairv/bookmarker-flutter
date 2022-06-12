import 'dart:math';
import 'package:bookmarker/databaseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

import 'mainScreen.dart';

class FolderScreen extends StatefulWidget {
  const FolderScreen({Key? key, this.user}) : super(key: key);
  final user;

  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  Future getFolders() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection("users")
        .doc(widget.user.uid)
        .collection("folders")
        .get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            getFolders();
          });
        },
        child: FutureBuilder(
          future: getFolders(),
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
                              builder: (context) => MainScreen(
                                  uid: widget.user.uid, folder: folderName),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
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
    );
  }
}
