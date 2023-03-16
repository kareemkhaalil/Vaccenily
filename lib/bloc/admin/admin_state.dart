part of 'admin_cubit.dart';

@immutable
abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminRegisterLoadingState extends AdminState {}

class AdminRegisterErrorState extends AdminState {
  final String error;
  AdminRegisterErrorState(this.error);
}

class AdminRegisterSuccessState extends AdminState {}

class AdminCreateSuccessState extends AdminState {}

class AdminGetUserLoadingState extends AdminState {}

class AdminGetUserSuccessState extends AdminState {
  AdminGetUserSuccessState(AdminModel user);
}

class AdminGetUserErrorState extends AdminState {
  final String error;
  AdminGetUserErrorState(this.error);
}

class AdminPickImageSuccessState extends AdminState {}

class AdminPickImageErrorState extends AdminState {
  final String error;
  AdminPickImageErrorState(this.error);
}

class AdminPickImageLoadingState extends AdminState {}

class AdminUpdateProfImageSuccessState extends AdminState {}

class AdminUpdateProfImageErrorState extends AdminState {
  final String error;
  AdminUpdateProfImageErrorState(this.error);
}

class AdminUpdateProfImageLoadingState extends AdminState {}

class AdminGetAllUsersLoadingState extends AdminState {}

class AdminGetAllUsersSuccessState extends AdminState {}

class AdminGetAllUsersErrorState extends AdminState {
  final String error;
  AdminGetAllUsersErrorState(this.error);
}

class AdminGetArticlesLoadingState extends AdminState {}

class AdminGetArticlesSuccessState extends AdminState {
  AdminGetArticlesSuccessState(List<ArticlesModel> articles);
}

class AdminGetArticlesErrorState extends AdminState {
  final String error;
  AdminGetArticlesErrorState(this.error);
}

class AdminGetIconsLoadingState extends AdminState {}

class AdminGetIconsSuccessState extends AdminState {
  AdminGetIconsSuccessState(List<IconsModel> icons);
}

class AdminGetIconsErrorState extends AdminState {
  final String error;
  AdminGetIconsErrorState(this.error);
}

class AdminGetTagsLoadingState extends AdminState {}

class AdminGetTagsSuccessState extends AdminState {
  AdminGetTagsSuccessState(List<TagsModel> tags);
}

class AdminGetTagsErrorState extends AdminState {
  final String error;
  AdminGetTagsErrorState(this.error);
}
