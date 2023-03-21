import 'package:bloc/bloc.dart';
import 'package:dashborad/data/models/adminModel.dart';
import 'package:dashborad/data/remote/repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  final Repository _repository;

  AdminCubit(this._repository) : super(AdminInitial());

  Future<void> addUser(AdminModel user) async {
    emit(AdminUserAdding());
    try {
      await _repository.addAdmin(user);
      emit(AdminUserAdded());
    } catch (e) {
      emit(AdminUserAddFailed(e.toString()));
    }
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
    } catch (e) {
      emit(AdminUserLoadFailed(e.toString()));
    }
  }
}
