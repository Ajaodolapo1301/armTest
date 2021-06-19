import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireAuth {
  static Future registerUsingEmailPassword({String firstname, String lastname, String email, String password,}) async {
    print("here");
    FirebaseAuth auth = FirebaseAuth.instance;
    var user;

    try {
        user   = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // user = userCredential.user;
      await user.updateProfile();
      await user.reload();
      user = auth.currentUser();

    } catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }
    return user;
  }




  static Future signInUsingEmailPassword({
     String email,
     String password,
     BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var user;

    try {
       user = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // user = userCredential.user;
    } catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }

    return user;
  }






}
