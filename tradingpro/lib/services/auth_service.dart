import 'package:firebase_auth/firebase_auth.dart' as firebase;

class AuthService {
  final firebase.FirebaseAuth _auth = firebase.FirebaseAuth.instance;

  Future<firebase.User?> signInWithEmail(String email, String password) async {
    try {
      firebase.UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
