import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashborad/bloc/dashboard_cubit.dart';
import 'package:dashborad/data/local/constans/constans.dart';

import 'package:dashborad/data/models/articlesModel.dart';
import 'package:dashborad/data/models/iconsModel.dart';
import 'package:dashborad/data/models/tagsModel.dart';
import 'package:file/file.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:meta/meta.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());
  DashboardState? dashboardState;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(AdminRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(AdminRegisterSuccessState());
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(email: email, name: name, uid: value.user!.uid);
    });
  }

  void userCreate({
    String? email,
    required String name,
    String? uid,
    double? postsCount,
  }) {
    try {
      AdminModel model = AdminModel(
        name: name,
        email: email,
        uid: uid,
        postsCount: postsCount,
      );
      FirebaseFirestore.instance
          .collection('admins')
          .doc(uid)
          .set(model.toJson());
      emit(AdminCreateSuccessState());
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  AdminModel? model;
  List<AdminModel> adminModels = []; // قم بتعريف قائمة من الـ adminModels
  StreamController<AdminModel> adminModelController =
      StreamController<AdminModel>.broadcast();
  Future<AdminModel?> getData() async {
    // يمكنك استخدام FirebaseAuth للحصول على معرف المستخدم الحالي
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;

      // استخدم دالة getUserData لجلب بيانات المستخدم المسجل دخوله
      AdminModel? loggedInAdmin;
      try {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection("users")
                .doc(uid.toString())
                .get();
        if (snapshot.exists) {
          loggedInAdmin = AdminModel.fromJson(snapshot.data());
        }
      } on FirebaseException catch (e) {
        print("Error getting admin data: ${e.message}");
      }
      return loggedInAdmin;
    } else {
      return null;
    }
  }

  getUserData(String uid) async {
    try {
      emit(AdminGetUserLoadingState());
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection("admins")
          .doc(uid.toString())
          .get();
      if (snapshot.exists) {
        AdminModel user = AdminModel.fromJson(snapshot.data());
        adminModelController.add(user);
        print(user.name);
        emit(AdminGetUserSuccessState(user));
      } else {
        emit(AdminGetUserErrorState("User does not exist"));
      }
    } on FirebaseException catch (e) {
      emit(AdminGetUserErrorState(e.message.toString()));
    }
  }

//pick image
  File? profileImageFile;
  var picker = ImagePickerPlugin();
  Future pickImage() async {
    emit(AdminPickImageLoadingState());
    final pickedFile = await picker.pickFile();
    if (pickedFile != null) {
      profileImageFile!.path == pickedFile.path.toString();
      print(pickedFile.path.toString());
    } else {
      print('No Image Selected');
      emit(AdminPickImageErrorState('No Image Selected'));
    }
  }

  //uploadImageFireBase

  void uploadProfileImage({
    required String name,
    required String phone,
  }) {
    try {
      emit(AdminUpdateProfImageLoadingState());
      FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(profileImageFile!.path).pathSegments.last}')
          .putFile(profileImageFile!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          print(value);
          updateUser(
            name: name,
            image: value,
          );
          emit(AdminUpdateProfImageSuccessState());
        });
      });
    } on FirebaseException catch (e) {
      emit(AdminUpdateProfImageErrorState(e.message!));
    }
  }

  void updateUser({
    required String name,
    String? image,
  }) {
    // emit(SocialUpdateLoadingState());
    AdminModel modelMap = AdminModel(
      name: name,
      email: model!.email,
      uid: model!.uid,
      image: image ?? model!.image,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uid)
        .update(modelMap.toMap())
        .then((value) {
      getUserData(
        model!.uid.toString(),
      );
    });
  }

  getAllUsers() {
    try {
      emit(AdminGetAllUsersLoadingState());

      FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          AdminModel adminModel = AdminModel.fromJson(
              Map<String, dynamic>.from(doc.data() as dynamic));
          adminModels.add(adminModel);
          emit(AdminGetAllUsersSuccessState());
        });
      });
    } on FirebaseException catch (e) {
      emit(AdminGetAllUsersErrorState(e.toString()));
    }
  }

  void getUserArticles(String uid) {
    try {
      emit(AdminGetAllUsersLoadingState());
      FirebaseFirestore.instance
          .collection('articles')
          .where('uid', isEqualTo: uid)
          .get()
          .then((value) {
        List<ArticlesModel> articles = [];
        value.docs.forEach((element) {
          articles.add(ArticlesModel.fromJson(element.data()));
        });
        emit(AdminGetArticlesSuccessState(articles));
      });
    } on FirebaseException catch (e) {
      emit(AdminGetAllUsersErrorState(e.message.toString()));
    }
  }

  void getUserIcons(String uid) {
    try {
      emit(AdminGetIconsLoadingState());
      FirebaseFirestore.instance
          .collection('icons')
          .where('uid', isEqualTo: uid)
          .get()
          .then((value) {
        List<IconsModel> icons = [];
        value.docs.forEach((element) {
          icons.add(IconsModel.fromJson(element.data()));
        });
        emit(AdminGetIconsSuccessState(icons));
      });
    } on FirebaseException catch (e) {
      emit(AdminGetIconsErrorState(e.message.toString()));
    }
  }

  void getUserTags(String uid) {
    try {
      emit(AdminGetTagsLoadingState());
      FirebaseFirestore.instance
          .collection('tags')
          .where('uid', isEqualTo: uid)
          .get()
          .then((value) {
        List<TagsModel> tags = [];
        value.docs.forEach((element) {
          tags.add(TagsModel.fromJson(element.data()));
        });
        emit(AdminGetTagsSuccessState(tags));
      });
    } on FirebaseException catch (e) {
      emit(AdminGetTagsErrorState(e.message.toString()));
    }
  }
}
