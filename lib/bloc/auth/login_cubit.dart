import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashborad/bloc/admin/admin_cubit.dart';
import 'package:dashborad/bloc/dashboard_cubit.dart';
import 'package:dashborad/data/local/constans/constans.dart';
import 'package:dashborad/data/models/adminModel.dart';
import 'package:dashborad/presentation/screens/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AdminModel? model;
  void adminLogin(BuildContext context) {
    final adminCubit = context.read<AdminCubit>();
    try {
      emit(LoginLoadingState());
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((value) {
        Constants().adminUID = value.user!.uid;
        adminCubit.getUserData(value.user!.uid);
        print(value.user!.uid);
        print(value.user!.email);
        adminCubit.getUserArticles(value.user!.uid);
        adminCubit.getUserIcons(value.user!.uid);
        adminCubit.getUserTags(value.user!.uid);
        adminCubit.getAllUsers();
        emit(LoginSuccessState(value.user!.uid));
        goToHome(context);
      });
    } on FirebaseException catch (e) {
      emit(LoginErrorState(e.message!));
    }
  }

  goToHome(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }

  void getUserData(uid) {
    try {
      emit(AdminGetUserLoadingState());
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get()
          .then((value) async {
        model = AdminModel.fromJson(value.data());
        print(model!.name);
        emit(AdminGetUserSuccessState());
      });
    } on FirebaseException catch (e) {
      print(e.message);
      print(e.code);
      emit(AdminGetUserErrorState(e.message!));
    }
  }

  init() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    model = AdminModel();
  }
}
