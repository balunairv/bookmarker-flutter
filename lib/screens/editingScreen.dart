import 'package:bookmarker/databaseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditingScreen extends StatefulWidget {
  EditingScreen(
      {Key? key,
      required this.uid,
      required this.folder,
      required this.title,
      required this.url,
      required this.docID})
      : super(key: key);
  String uid;
  String folder, title, url, docID;

  @override
  State<EditingScreen> createState() => _EditingScreenState();
}

class _EditingScreenState extends State<EditingScreen> {
  _EditingScreenState();
  String title = '';
  String url = '';

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
                    hintText: widget.title,
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
                    hintText: widget.url,
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
                  print('url : $url title: $title   ');
                  if (title.isEmpty) {
                    title = widget.title;

                    DatabaseServices(uid: widget.uid).updateBookmark(
                        updatedTitle: title,
                        url: url,
                        folder: widget.folder,
                        docID: widget.docID);
                  }
                  if (url.isEmpty) {
                    url = widget.url;
                    DatabaseServices(uid: widget.uid).updateBookmark(
                      updatedTitle: title,
                      url: url,
                      folder: widget.folder,
                      docID: widget.docID,
                    );
                  }

                  Navigator.pop(context);
                },
                child: Text(
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  "Update",
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    minimumSize: Size(290, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
