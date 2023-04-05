import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper {
  FireStoreHelper._();

  static final FireStoreHelper fireStoreHelper = FireStoreHelper._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference? collectionReference;

  connectCollection() {
    collectionReference = firestore.collection('Notes');
  }

  Future<void> addNotes({required title, required note}) async {
    connectCollection();
    int uniqueId = DateTime.now().millisecondsSinceEpoch;
    await collectionReference!
        .doc(uniqueId.toString())
        .set({
          'id': uniqueId,
          'title': title,
          'description': note,
        })
        .then((value) => print("Notes added...."))
        .catchError((error) => print("$error"));
  }

  Stream<QuerySnapshot<Object?>> getNotes() {
    connectCollection();
    return collectionReference!.snapshots();
  }

  editNotes({required String id, required Map<Object, Object> data}) {
    connectCollection();

    collectionReference!
        .doc(id)
        .update(data)
        .then((value) => print("note edited..."))
        .catchError((error) => print("$error"));
  }

  deleteNotes({required String id}) {
    connectCollection();

    collectionReference!
        .doc(id)
        .delete()
        .then((value) => print("Note Deleted..."))
        .catchError((error) => print('$error'));
  }
}
