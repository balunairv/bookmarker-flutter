import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../databaseService.dart';

class GroupBookmarkAddingScreen extends StatefulWidget {
  GroupBookmarkAddingScreen(
      {Key? key, required this.uid, required this.uniqueID})
      : super(key: key);
  String uid;
  String uniqueID;
  @override
  State<GroupBookmarkAddingScreen> createState() =>
      _GroupBookmarkAddingScreenState(uid, uniqueID);
}

class _GroupBookmarkAddingScreenState extends State<GroupBookmarkAddingScreen> {
  String uid, uniqueID;
  _GroupBookmarkAddingScreenState(this.uid, this.uniqueID);
  String title = "";
  String url = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    fillColor: Colors.green,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onChanged: (val) {
                    setState(() => title = val);
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'URL',
                    fillColor: Colors.green,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onChanged: (val) {
                    setState(() => url = val);
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  DatabaseServices(uid: uid).addGroupBookmark(
                      title: title, url: url, uniqueID: widget.uniqueID);
                  Navigator.pop(context);
                },
                child: Text(
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  "Create",
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    minimumSize: Size(290, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100))),
              ),
              Text(widget.uniqueID),
            ],
          ),
        ),
      ),
    );
  }
}
