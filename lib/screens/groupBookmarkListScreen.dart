import 'package:bookmarker/screens/groupBookmarkAddingScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import 'addingScreen.dart';

class GroupBookmarkListScreen extends StatefulWidget {
  const GroupBookmarkListScreen(
      {Key? key,
      required this.uid,
      required this.group,
      required this.uniqueID})
      : super(key: key);
  final String uid, group, uniqueID;
  @override
  State<GroupBookmarkListScreen> createState() =>
      _GroupBookmarkListScreenState();
}

class _GroupBookmarkListScreenState extends State<GroupBookmarkListScreen> {
  Future getBookmarks() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection("groups")
        .doc(widget.uniqueID)
        .collection("bookmarks")
        .get();

    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.group),
        actions: [
          IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: widget.uniqueID)).then(
                    (value) => //only if ->
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Unique ID of the group copied to clipboard. Use it to search for the group"))));
              },
              icon: Icon(Icons.share)),
        ],
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
                      'https://assets6.lottiefiles.com/packages/lf20_0zomy8eb.json'),
                );
              } else {
                var myList = snapshot.data! as List<QueryDocumentSnapshot>;
                return ListView.builder(
                    itemCount: myList.length,
                    itemBuilder: (context, index) {
                      String titleText = myList[index]['title'].toString();
                      String url = myList[index]['url'].toString();
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: ExpansionTile(
                          title: Text(titleText),
                          trailing:
                              const Icon(Icons.arrow_circle_right_rounded),
                          leading: const Icon(Icons.link_rounded),
                          backgroundColor: Color.fromARGB(255, 176, 250, 178),
                          expandedCrossAxisAlignment:
                              CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  launchUrl(Uri.parse(url),
                                      mode: LaunchMode.inAppWebView);
                                },
                                child: Text('Open Here')),
                            ElevatedButton(
                                onPressed: () {
                                  launchUrl(Uri.parse(url),
                                      mode: LaunchMode.externalApplication);
                                },
                                child: Text('Open in Browser')),
                          ],
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
          String userId = widget.uid.toString();
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => GroupBookmarkAddingScreen(
                      uid: userId, uniqueID: widget.uniqueID.toString()))));
        },
        label: Text(widget.uniqueID.toString()),
        icon: const Icon(
          Icons.add,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
