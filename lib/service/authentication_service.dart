import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      _firebaseAuth.currentUser!.updateDisplayName(name);

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'Email já está em uso.';
      }
      return 'Erro desconhecido';
    }
  }

  Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        return 'Credenciais inválidas.';
      }
      return 'Erro desconhecido';
    }
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> updateUserPhoto(String url) async {
    await _firebaseAuth.currentUser!.updatePhotoURL(url);
  }
}
