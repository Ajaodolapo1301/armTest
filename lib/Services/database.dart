

import 'package:cloud_firestore/cloud_firestore.dart';

final Firestore firestore = Firestore.instance;
final CollectionReference _mainCollection = firestore.collection('messages');


class Database {
  static String userUid;

  static Future<void> addItem({
       String title,
       String description,
        String  imageUrl,
    String sender,
  }) async {
    firestore.collection("messages").add(
        {
      "title" : title,
      "Description" : description,
        "images" : imageUrl,
        "sender" : sender
    }
    );
  }


  static Future<void> updateItem({
    String title,
    String description,
    String  imageUrl,
    String sender,
     String docId,
  }) async {
    // DocumentReference documentReferencer =
    // _mainCollection.document().collection('messages').document(docId);
    Map<String, dynamic> data = <String, dynamic>{
      "title" : title,
      "Description" : description,
      "images" : imageUrl,
      "sender" : sender

    };
    firestore.collection("messages").document(docId).updateData(data);


    // await documentReferencer
    //     .updateData(data)
    //     .whenComplete(() => print("Note item updated in the database"))
    //     .catchError((e) => print(e));
  }



  static Future<void> deleteItem({
     String docId,
  }) async {

    firestore.collection("messages").document(docId).delete();

  }

}