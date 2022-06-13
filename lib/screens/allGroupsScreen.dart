import 'dart:math';

import 'package:bookmarker/screens/groupAddingScreen.dart';
import 'package:bookmarker/screens/groupBookmarkListScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../databaseService.dart';
import 'folderAddingScreen.dart';
import 'bookmarkListScreen.dart';

class AllGroupsScreen extends StatefulWidget {
  AllGroupsScreen({Key? key, required this.user}) : super(key: key);
  final user;
  @override
  State<AllGroupsScreen> createState() => _AllGroupsScreenState();
}

class _AllGroupsScreenState extends State<AllGroupsScreen> {
  Future getFolders() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection("users")
        .doc(widget.user.uid)
        .collection("groups")
        .get();
    return qn.docs;
  }

  String groupID = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groups'),
        actions: [
          IconButton(
              onPressed: () async {
                String userId = widget.user.uid.toString();
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => GroupAddingScreen(
                              uid: userId,
                            ))));
              },
              icon: const Icon(Icons.add))
        ],
      ),
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
                  String groupName = myList[index]['title'].toString();
                  String iconUrl = myList[index]['icon_url'].toString();
                  String uniqueID = myList[index]['uniqueID'].toString();
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GroupBookmarkListScreen(
                                uid: widget.user.uid,
                                group: groupName,
                                uniqueID: uniqueID,
                              ),
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
                              groupName,
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
        onPressed: () {
          Alert(
            context: context,
            type: AlertType.warning,
            title: "JOIN GROUP",
            desc: "Search with unique ID of grou",
            buttons: [
              DialogButton(
                child: TextField(
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  onChanged: (val) {
                    setState(() {
                      groupID = val.toString();
                    });
                  },
                ),
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(116, 116, 191, 1.0),
                  Color.fromRGBO(52, 138, 199, 1.0)
                ]),
                onPressed: () {
                  DatabaseServices(uid: widget.user.uid)
                      .searchAdd(uniqueID: groupID);
                },
              ),
              DialogButton(
                child: Text(
                  "Find and Add",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                color: Color.fromRGBO(0, 179, 134, 1.0),
              ),
            ],
          ).show();
        },
        label: const Text('Search'),
        icon: const Icon(
          Icons.search,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
