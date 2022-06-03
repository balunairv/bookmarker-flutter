import 'package:bookmarker/databaseService.dart';
import 'package:flutter/material.dart';

class AddingScreen extends StatefulWidget {
  AddingScreen({Key? key, required this.uid}) : super(key: key);
  String uid;

  @override
  State<AddingScreen> createState() => _AddingScreenState(uid);
}

class _AddingScreenState extends State<AddingScreen> {
  String uid;
  _AddingScreenState(this.uid);
  String title = "";
  String url = "";
  String dropDownVal = 'Select Folder';
  final items = [
    'Select Folder',
    'Youtube',
    'Instagram',
    'Chrome',
    'Twitter',
    'Other'
  ];
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
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.green)),
                child: DropdownButton(
                  isExpanded: true,
                  items: items.map((itemsName) {
                    return DropdownMenuItem(
                      value: itemsName,
                      child: Text(itemsName),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      dropDownVal = newValue.toString();
                    });
                  },
                  value: dropDownVal,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  DatabaseServices(uid: uid)
                      .addBookmark(title: title, url: url, folder: dropDownVal);
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
