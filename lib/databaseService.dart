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
        .collection(folder);
    return await folderCollection.doc(title).set({
      'title': title,
      'url': url,
      // 'folder': folder,
    });
  }
}
