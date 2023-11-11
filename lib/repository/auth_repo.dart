import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

final userRecord = FirebaseFirestore.instance.collection('users');

class AuthRepo {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  Duration get loginTime => const Duration(milliseconds: 1000);
  firebase_auth.FirebaseException? firebaseException;

  AuthRepo({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  var currentUser = User.empty;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : toUser(firebaseUser);
      currentUser = user;
      return user;
    });
  }

  Future signUp({required email, required password}) async {
    return Future.delayed(loginTime).then((context) async {
      try {
        await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password!);
        _firebaseAuth.currentUser!.sendEmailVerification();
      } on firebase_auth.FirebaseAuthException catch (e) {
        firebaseException = e;
        // print('firebase exception $firebaseException');
      }
      if (firebaseException != null) {
        if (firebaseException!.message != 'email address is already in use') {
          return 'Email already in use; Try different one';
        }
      }
      // return null;
    });
  }

  Future login({required email, required password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on firebase_auth.FirebaseAuthException catch (e) {
      firebaseException = e;
      print('exception: ${e.message}');
    }

    return Future.delayed(loginTime).then((_) {
      if (firebaseException?.message != null) {
        if (firebaseException!.message!.contains('There is no user record')) {
          return 'User Invalid';
        } else if (firebaseException!.message!
            .contains('password is invalid')) {
          return 'Password Was Incorrect';
        } else {
          return 'Something unforeseen went wrong!';
        }
      }
    });
  }

  Future logout() async {
    try {
      Future.wait([_firebaseAuth.signOut()]);
    } on firebase_auth.FirebaseAuthException catch (e) {
      print('LOGOUT ERROR: $e');
    }
  }

  Future recoverPassword({required String email}) async {
    return Future.delayed(loginTime).then((_) async {
      try {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } on firebase_auth.FirebaseAuthException catch (e) {
        firebaseException = e;
        // print('firebase exception $e');
      }
      if (firebaseException != null) {
        if (firebaseException!.message!.contains('no user record')) {
          return ' User Not Found - Incorrect Email?';
        }
      }
      return null;
    });
  }

  User toUser(dynamic firebaseUser) => User(
      id: firebaseUser.uid,
      email: firebaseUser.email,
      name: firebaseUser.displayName,
      photo: firebaseUser.photoURL);

  //   extension on firebase_auth.FirebaseAuth.User{
  //   User get toUser {return User(id: uid, email: email, name: displayName, photo: photoURL);}
  // }
}
