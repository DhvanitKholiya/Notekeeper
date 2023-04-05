import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Firebase_auth_helper {
  Firebase_auth_helper._();

  static final Firebase_auth_helper firebase_auth_helper =
      Firebase_auth_helper._();

  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<Map<String,dynamic>> signWithGoogle() async {
    Map<String, dynamic> res = {};

    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);

      User? user = userCredential.user;

      res['user'] = user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          res['error'] = "This service is temporary down....";
          break;
      }
    }
    return res;
  }

  Future<Map<String,dynamic>>signUp({required email , required password}) async{
    Map<String,dynamic> res = {};
    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      res['user'] = user;
    }
    on FirebaseAuthException catch(e) {
      switch (e.code) {
        case "operation-not-allowed":
          res['error'] = "This service is temporary down...";
          break;
      }
    }
    return res;
  }

  Future<Map<String,dynamic>>signIn({required email,required password}) async {
    Map<String,dynamic> res = {};

    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      res['user'] = user;
    }
    on FirebaseAuthException catch(e) {
      switch (e.code) {
        case "operation-not-allowed":
          res['error'] = "This service is temporary down...";
          break;
      }
    }
    return res;
  }
}
