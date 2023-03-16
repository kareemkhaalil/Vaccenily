part of 'icons_cubit.dart';

@immutable
abstract class IconsState {}

class IconsInitial extends IconsState {}

class IconsGetloadingState extends IconsState {}

class IconsGetSuccessState extends IconsState {}

class IconsGetErrorState extends IconsState {
  final String error;

  IconsGetErrorState(this.error);
}

class IconsCreatingLoadingState extends IconsState {}

class IconsCreateSuccessState extends IconsState {}

class IconsCreateErrorState extends IconsState {
  final String error;

  IconsCreateErrorState(this.error);
}

class IconsDeleteLoadingState extends IconsState {}

class IconsDeleteSuccessState extends IconsState {}

class IconsDeleteErrorState extends IconsState {
  final String error;

  IconsDeleteErrorState(this.error);
}

class IconsUpdateLoadingState extends IconsState {}

class IconsUpdateSuccessState extends IconsState {}

class IconsUpdateErrorState extends IconsState {
  final String error;

  IconsUpdateErrorState(this.error);
}

class IconsUploadImageLoadingState extends IconsState {}

class IconsUploadImageSuccessState extends IconsState {}

class IconsUploadImageErrorState extends IconsState {
  final String error;

  IconsUploadImageErrorState(this.error);
}

class IconsPickImageLoadingState extends IconsState {}

class IconsPickImageSuccessState extends IconsState {}

class IconsPickImageErrorState extends IconsState {
  final String error;

  IconsPickImageErrorState(this.error);
}

class IconsGetByIdLoadingState extends IconsState {}

class IconsGetByIdSuccessState extends IconsState {}

class IconsGetByIdErrorState extends IconsState {
  final String error;

  IconsGetByIdErrorState(this.error);
}

class IconsLoaded extends IconsState {
  final List<IconsModel> icons;

  IconsLoaded(this.icons);

  List<IconsModel> get iconsData => icons;
}
