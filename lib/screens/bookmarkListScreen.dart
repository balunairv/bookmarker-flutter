import 'package:bookmarker/screens/addingScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:lottie/lottie.dart';

import 'package:url_launcher/url_launcher.dart';

class BookmarkListScreen extends StatefulWidget {
  BookmarkListScreen({Key? key, required this.uid, required this.folder})
      : super(key: key);

  String uid, folder;

  @override
  State<BookmarkListScreen> createState() => _BookmarkListScreenState();
}

class _BookmarkListScreenState extends State<BookmarkListScreen> {
  String SearchData = "";
  Future getBookmarks() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection("users")
        .doc(widget.uid)
        .collection("folders")
        .doc(widget.folder)
        .collection('bookmarks')
        .get();

    return qn.docs;
  }

  final searchController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.folder),
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
                return Column(children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Search Title',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: Colors.blue))),
                      onChanged: (val) {
                        setState(() {
                          SearchData = val;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: myList.length,
                        itemBuilder: (context, index) {
                          String titleText = myList[index]['title'].toString();
                          String url = myList[index]['url'].toString();

                          if (SearchData.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: ExpansionTile(
                                title: Text(titleText),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: const Text('Alert'),
                                              content: const Text(
                                                  "Are you sure to delete the bookmark. This action cannot be changed later"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child:
                                                        const Text('Cancel')),
                                                TextButton(
                                                    onPressed: () async {
                                                      final docBookmark =
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "users")
                                                              .doc(widget.uid)
                                                              .collection(
                                                                  "folders")
                                                              .doc(
                                                                  widget.folder)
                                                              .collection(
                                                                  'bookmarks')
                                                              .doc(titleText);
                                                      docBookmark.delete();
                                                      Navigator.pop(context);
                                                    },
                                                    child:
                                                        const Text('Delete')),
                                              ],
                                            ));
                                  },
                                ),
                                leading: const Icon(Icons.link_rounded),
                                backgroundColor:
                                    const Color.fromARGB(255, 176, 250, 178),
                                expandedCrossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        launchUrl(Uri.parse(url),
                                            mode: LaunchMode.inAppWebView);
                                      },
                                      child: const Text('Open Here')),
                                  ElevatedButton(
                                      onPressed: () {
                                        launchUrl(Uri.parse(url),
                                            mode:
                                                LaunchMode.externalApplication);
                                      },
                                      child: const Text('Open in Browser')),
                                ],
                              ),
                            );
                          }
                          if (myList[index]['title']
                              .toString()
                              .startsWith(SearchData.toLowerCase())) {
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: ExpansionTile(
                                title: Text(titleText),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: const Text('Alert'),
                                              content: const Text(
                                                  "Are you sure to delete the bookmark. This action cannot be changed later"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child:
                                                        const Text('Cancel')),
                                                TextButton(
                                                    onPressed: () async {
                                                      final docBookmark =
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "users")
                                                              .doc(widget.uid)
                                                              .collection(
                                                                  "folders")
                                                              .doc(
                                                                  widget.folder)
                                                              .collection(
                                                                  'bookmarks')
                                                              .doc(titleText);
                                                      docBookmark.delete();
                                                      Navigator.pop(context);
                                                    },
                                                    child:
                                                        const Text('Delete')),
                                              ],
                                            ));
                                  },
                                ),
                                leading: const Icon(Icons.link_rounded),
                                backgroundColor:
                                    Color.fromARGB(255, 176, 250, 178),
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
                                            mode:
                                                LaunchMode.externalApplication);
                                      },
                                      child: Text('Open in Browser')),
                                ],
                              ),
                            );
                          }
                          return Container();
                        }),
                  ),
                ]);
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
                  builder: ((context) =>
                      AddingScreen(uid: userId, folder: widget.folder))));
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
