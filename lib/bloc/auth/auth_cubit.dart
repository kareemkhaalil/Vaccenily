import 'package:bloc/bloc.dart';
import 'package:dashborad/bloc/admin/admin_cubit.dart';
import 'package:dashborad/data/remote/fireAuth.dart';
import 'package:dashborad/presentation/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final Auth _fireAuth;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AdminCubit adminCubit;

  AuthCubit(this._fireAuth, this.adminCubit) : super(AuthInitial());

  Future<void> signIn(String email, String password, context) async {
    emit(AuthLoading());

    try {
      await _fireAuth.signInWithEmailAndPassword(email, password);
      await adminCubit.getUser();
      emit(AuthSuccess());
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(
                    adminCubit: adminCubit,
                  )));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(AuthLoading());

    try {
      await _fireAuth.createUserWithEmailAndPassword(email, password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());

    try {
      await _fireAuth.signOut();
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
