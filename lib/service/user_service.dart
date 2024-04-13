import 'package:barbearia_dos_brabos/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  late String userId;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  UserService() {
    initializeUserId();
  }

  Future<void> initializeUserId() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      userId = currentUser.uid;
    }
  }

  Future<void> createUserInFirestore(UserModel userModel) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(userModel.id)
          .set(userModel.toMap());
    } on FirebaseException catch (e) {
      print('AQUI O ERRO DE CADASTRAMENDO NO CLOUD FIREBASE: $e');
    }
  }

  getUserFirestore(String userEmail) async {
    try {
      return await _firebaseFirestore
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .snapshots();
    } on FirebaseException catch (e) {
      print('Informação não encontrada $e');
    }
  }
}
