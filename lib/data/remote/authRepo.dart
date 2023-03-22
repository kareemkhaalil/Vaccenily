import 'package:dashborad/data/models/adminModel.dart';
import 'package:dashborad/data/remote/fireAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final Auth _auth = Auth();

  User? getCurrentUser() {
    return _auth.getCurrentUser();
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    return _auth.signInWithEmailAndPassword(email, password);
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    return _auth.createUserWithEmailAndPassword(email, password);
  }

  Future<void> signOut() async {
    _auth.signOut();
  }
}
