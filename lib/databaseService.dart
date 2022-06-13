import 'package:cloud_firestore/cloud_firestore.dart';

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

    return await folderCollection.doc(title).set({
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

  Future addGroups({folderName, folderIcon, uniqueID}) async {
    final CollectionReference folderCollection =
        FirebaseFirestore.instance.collection('groups');

    return await folderCollection.doc(uniqueID).set(
        {'title': folderName, 'icon_url': folderIcon, 'uniqueID': uniqueID});
  }

  Future addGroupsInUser({folderName, folderIcon, uniqueID}) async {
    final CollectionReference folderCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('groups');

    return await folderCollection.doc(uniqueID).set({
      'title': folderName,
      'icon_url': folderIcon,
      'uniqueID': uniqueID,
    });
  }

  Future searchAdd({uniqueID}) async {
    final CollectionReference folderCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('groups');

    return await folderCollection.doc(uniqueID).set({
      'uniqueID': uniqueID,
    });
  }
}
