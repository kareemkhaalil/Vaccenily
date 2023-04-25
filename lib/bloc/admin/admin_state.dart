part of 'admin_cubit.dart';

@immutable
abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminUserAdding extends AdminState {}

class AdminUserAdded extends AdminState {}

class AdminUserSignUp extends AdminState {}

class AdminUserImageUploading extends AdminState {}

class AdminUserImageUploaded extends AdminState {}

class AdminUserImageUploadFailed extends AdminState {
  final String errorMessage;

  AdminUserImageUploadFailed(this.errorMessage);
}

class AdminImagePicked extends AdminState {}

class AdminUserAddFailed extends AdminState {
  final String error;

  AdminUserAddFailed(this.error);
}

class AdminUserDeleting extends AdminState {}

class AdminUserDeleted extends AdminState {}

class AdminUserDeleteFailed extends AdminState {
  final String error;

  AdminUserDeleteFailed(this.error);
}

class AdminUserUpdating extends AdminState {}

class AdminUserUpdated extends AdminState {}

class AdminUserUpdateFailed extends AdminState {
  final String error;

  AdminUserUpdateFailed(this.error);
}

class AdminUserLoading extends AdminState {}

class AdminUserLoaded extends AdminState {}

class AdminUserLoadFailed extends AdminState {
  final String error;

  AdminUserLoadFailed(this.error);
}

class AdminsLoading extends AdminState {}

class AdminsLoaded extends AdminState {}

class AdminsLoadFailed extends AdminState {
  final String error;

  AdminsLoadFailed(this.error);
}

class CreateUserLoading extends AdminState {}

class CreateUserSuccess extends AdminState {}

class CreateUserFailed extends AdminState {
  final String error;

  CreateUserFailed(this.error);
}
