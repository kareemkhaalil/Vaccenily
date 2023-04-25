import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dashborad/data/models/adminModel.dart';
import 'package:dashborad/data/remote/repo.dart';
import 'package:file/file.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:universal_html/html.dart' as html;

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  final Repository _repository;
  html.File? image;
  String? imageUrl;
  final imageUrlStreamController = StreamController<String?>.broadcast();

  AdminCubit(this._repository) : super(AdminInitial());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool addAdminLoadind = false;
  Future createUser() async {
    emit(CreateUserLoading());
    try {
      print("add user to model ");
      AdminModel user = AdminModel(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        image: imageUrl,
      );
      print(nameController.text);
      print(emailController.text);
      print(passwordController.text);
      await addUser(user);

      nameController.clear();
      emailController.clear();
      passwordController.clear();
      // مسح متغير imageUrl
      imageUrl = null;
      imageUrlStreamController.add(null);
      emit(CreateUserSuccess());
    } on FirebaseException catch (e) {
      emit(
        CreateUserFailed(
          e.toString(),
        ),
      );
      print(
        e,
      );
    }
  }

  Future<void> addUser(AdminModel user) async {
    emit(AdminUserAdding());
    try {
      print("call addUser fun  ");
      await _repository.addAdmin(user);
      emit(AdminUserAdded());
    } catch (e) {
      emit(AdminUserAddFailed(e.toString()));
      print(e);
    }
  }

  Future pickImage() async {
    try {
      Completer<void> completer = Completer<void>();
      html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
      uploadInput.click();

      uploadInput.onChange.listen((event) {
        final file = uploadInput.files!.first;
        final reader = html.FileReader();

        reader.readAsDataUrl(file);
        reader.onLoadEnd.listen((event) {
          image = file;
          imageUrl = reader.result as String?;
          imageUrlStreamController.add(imageUrl);
          emit(AdminImagePicked());
          completer.complete();
          print(
              'Image have been picked '); // Complete the Future when the image is loaded
        });
      });

      return completer.future; // Return the Future
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future onAddAdminButtonPressed() async {
    addAdminLoadind = true;

    try {
      await createUser();
    } catch (e) {
      // معالجة الاستثناءات هنا
    } finally {
      addAdminLoadind = false;
    }
  }

  Future<void> uploadImage() async {
    if (image != null) {
      emit(AdminUserImageUploading());
      try {
        // استخدم getUser() للحصول على معرف المستخدم الحالي
        final currentUser = await getUser();
        final userId = currentUser.uid;

        // ارفع الصورة وقم بتحديث مسار الصورة في مستند المستخدم
        await _repository.uploadAdminImage(image, userId);
        emit(AdminUserImageUploaded());
      } catch (e) {
        emit(AdminUserImageUploadFailed(e.toString()));
      }
    } else {
      print('يرجى اختيار صورة قبل المحاولة مرة أخرى.');
    }
  }

  @override
  Future<void> close() {
    imageUrlStreamController.close(); // إغلاق المصدر عند إغلاق الكابيت
    return super.close();
  }

  Future<void> deleteUser(String userId) async {
    emit(AdminUserDeleting());
    try {
      await _repository.deleteAdmin(userId);
      emit(AdminUserDeleted());
    } catch (e) {
      emit(AdminUserDeleteFailed(e.toString()));
    }
  }

  Future<void> updateUser(AdminModel updatedUser) async {
    emit(AdminUserUpdating());
    try {
      await _repository.updateAdmin(updatedUser);
      emit(AdminUserUpdated());
    } catch (e) {
      emit(AdminUserUpdateFailed(e.toString()));
    }
  }

  Future getAllUsers() async {
    emit(AdminsLoading());
    try {
      var users = await _repository.getAllAdmins();
      emit(AdminsLoaded());
      return users;
    } on FirebaseException catch (e) {
      emit(AdminsLoadFailed(e.toString()));
      print(e.message);
    }
  }

  Future getUser() async {
    emit(AdminUserLoading());
    try {
      User? currentUser = _repository.getCurrentUser();
      String adminId = currentUser!.uid;
      var user = await _repository.getCurrentAdmin(adminId);
      emit(AdminUserLoaded());
      return user;
    } on FirebaseException catch (e) {
      emit(AdminUserLoadFailed(e.toString()));
    }
  }
}
