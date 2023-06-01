import 'package:firebase_auth/firebase_auth.dart';

loginUser(email, password) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      return e;
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      return e;
    }
  }
}

signOut() async {
  await FirebaseAuth.instance.signOut();
}
