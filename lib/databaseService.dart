import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatabaseServices {
  final String uid;

  DatabaseServices({required this.uid});
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  Future addBookmark({title, url, folder}) async {
    final CollectionReference folderCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('folders')
        .doc(folder)
        .collection('bookmarks');

    return await folderCollection.doc().set({
      'title': title,
      'url': url,
      // 'folder': folder,
    });
  }

  Future addGroupBookmark({title, url, uniqueID}) async {
    final CollectionReference folderCollection = FirebaseFirestore.instance
        .collection('groups')
        .doc(uniqueID)
        .collection('bookmarks');

    return await folderCollection.doc(title).set({
      'title': title,
      'url': url,
      // 'uniqueID': uniqueID,
      // 'folder': folder,
    });
  }

  Future addFolders({folderName, folderIcon}) async {
    final CollectionReference folderCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('folders');
    return await folderCollection
        .doc(folderName)
        .set({'title': folderName, 'iconUrl': folderIcon});
  }

  Future addGroups({groupName, groupIcon, required uniqueID}) async {
    final CollectionReference groupCollection =
        FirebaseFirestore.instance.collection('groups');

    return await groupCollection.doc(uniqueID).set({
      'title': groupName,
      'icon_url': groupIcon,
    });
  }

  Future addGroupsInUser(
      {required uniqueID, required groupName, required groupIcon}) async {
    final CollectionReference folderCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('groups');

    return await folderCollection.doc(uniqueID).set({
      'uniqueID': uniqueID,
      'title': groupName,
      'icon_url': groupIcon,
    });
  }

  Future searchAdd({required uniqueID}) async {
    await FirebaseFirestore.instance
        .collection('groups')
        .doc(uniqueID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        String title = documentSnapshot['title'];
        // print('Document data: ${documentSnapshot.data()}');
        String groupName = documentSnapshot.get('title');
        String groupIcon = documentSnapshot.get('icon_url');
        addGroupsInUser(
            uniqueID: uniqueID, groupName: groupName, groupIcon: groupIcon);
      } else {}
      ;
    });
  }

  Future updateBookmark({title, url, folder, updatedTitle, required docID}) {
    final DocumentReference docReference = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('folders')
        .doc(folder)
        .collection('bookmarks')
        .doc(docID);

    return docReference
        .update({
          'title': updatedTitle,
          'url': url,
        })
        .then((value) => print(
            'Success $title url: $url updatedTitle : $updatedTitle DocID: $docID '))
        .catchError((error) => print(
            'Error : $error title :$title url: $url updatedTitle : $updatedTitle'));
  }
}
