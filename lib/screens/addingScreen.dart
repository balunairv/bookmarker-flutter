import 'package:bookmarker/databaseService.dart';
import 'package:flutter/material.dart';

class AddingScreen extends StatefulWidget {
  AddingScreen({Key? key, required this.uid, required this.folder})
      : super(key: key);
  String uid;
  String folder;

  @override
  State<AddingScreen> createState() => _AddingScreenState(uid, folder);
}

class _AddingScreenState extends State<AddingScreen> {
  String uid, folder;
  _AddingScreenState(this.uid, this.folder);
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
                  DatabaseServices(uid: uid).addBookmark(
                      title: title, url: url, folder: widget.folder);
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
              Text(uid),
            ],
          ),
        ),
      ),
    );
  }
}
