import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireAuth {
  static Future<User> registerUsingEmailPassword({String firstname, String lastname, String email, String password,}) async {
    print("here");
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user.updateProfile(displayName: "$firstname $lastname");
      await user.reload();
      user = auth.currentUser;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }




  static Future<User> signInUsingEmailPassword({
     String email,
     String password,
     BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }

    return user;
  }
}
