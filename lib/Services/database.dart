

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
// final CollectionReference _mainCollection = firestore.collection('messages');


class Database {
  static String userUid;

  static Future<void> addItem({
    String title,
    String description,
    String imageUrl,
    String sender,
  }) async {


    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "Description": description,
      "images": imageUrl,
      "sender": sender
    };
    FirebaseFirestore.instance.collection("messages")
        .doc(userUid)
        .set(data, SetOptions(merge: true)).then((value) {

    });
  }





    static Future<void> updateItem({
      String title,
      String description,
      String  imageUrl,
      String sender,
       String docId,
    }) async {


      Map<String, dynamic> data = <String, dynamic>{
        "title" : title,
        "Description" : description,
        "images" : imageUrl,
        "sender" : sender

      };
      FirebaseFirestore.instance.collection("messages")
          .doc(docId)
          .update(data).then((value)  {

      });


    }



    static Future<void> deleteItem({
       String docId,
    }) async {
      FirebaseFirestore.instance.collection("messages")
          .doc(docId)
          .delete().then((value)  {

      });

    }


}