import 'package:flutter/material.dart';

import '../databaseService.dart';

class GroupAddingScreen extends StatefulWidget {
  const GroupAddingScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);
  final String uid;

  @override
  State<GroupAddingScreen> createState() => _GroupAddingScreenState(uid);
}

class _GroupAddingScreenState extends State<GroupAddingScreen> {
  String uid;
  _GroupAddingScreenState(this.uid);

  String title = "";
  String uniqueID = "";
  String dropDownVal = 'Other';
  final items = [
    'Video',
    'Pictures',
    'Blogs',
    'Sites',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Unique ID',
                    fillColor: Colors.green,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onChanged: (val) {
                    setState(() => uniqueID = val);
                  },
                ),
              ),
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
                  String folderIcon = folderIconpicker(dropDownVal).getICon();
                  DatabaseServices(uid: uid).addGroups(
                      groupName: title,
                      groupIcon: folderIcon,
                      uniqueID: uniqueID);
                  DatabaseServices(uid: uid).addGroupsInUser(
                      uniqueID: uniqueID,
                      groupIcon: folderIcon,
                      groupName: title);
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
            ],
          ),
        ),
      ),
    );
  }
}

class folderIconpicker {
  String dropdownVal;
  folderIconpicker(this.dropdownVal);

  getICon() {
    switch (dropdownVal) {
      case 'Video':
        return 'https://assets5.lottiefiles.com/packages/lf20_6ywhhblw.json';

      case 'Pictures':
        return 'https://assets8.lottiefiles.com/packages/lf20_miwpcyh5.json';

      case 'Blogs':
        return 'https://assets7.lottiefiles.com/packages/lf20_ix3uud7u.json';

      case 'Sites':
        return 'https://assets6.lottiefiles.com/packages/lf20_puu4hfmk.json';

      default:
        return 'https://assets2.lottiefiles.com/packages/lf20_hi95bvmx/WebdesignBg.json';
    }
  }
}
