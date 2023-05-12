// ignore_for_file: file_names

import 'package:dashborad/data/local/hive/hiveServices.dart';
import 'package:dashborad/data/models/userHiveModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final HiveService _hiveService = HiveService();

// تسجيل الدخول
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _hiveService.saveUser(UserHive(
        email: email,
        password: password,
        id: userCredential.user!.uid,
      ));

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return null;
    }
  }

// التسجيل
  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException {
      // يمكنك التعامل مع الأخطاء هنا
      return null;
    }
  }

// تسجيل الخروج
  // تسجيل الخروج
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _hiveService.deleteUser();
    } on FirebaseException catch (e) {
      print(e);
    }
  }

// الحصول على المستخدم الحالي
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
