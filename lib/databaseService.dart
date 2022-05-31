import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final String uid;
  DatabaseServices({required this.uid});
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  Future addBookmark(String title, String url, String folder) async {
    return await userCollection.doc(uid).set({
      'title': title,
      'url': url,
      'folder': folder,
    });
  }
}
