part of 'tags_cubit.dart';

@immutable
abstract class TagsState {}

class TagsInitial extends TagsState {}

class TagsCreateSuccessState extends TagsState {}

class TagsCreateErrorState extends TagsState {
  final String error;
  TagsCreateErrorState(this.error);
}

class TagsCreatingLoadingState extends TagsState {}

class TagsGetloadingState extends TagsState {}

class TagsGetSuccessState extends TagsState {}

class TagsGetErrorState extends TagsState {
  final String error;
  TagsGetErrorState(this.error);
}

class TagsPickImageLoadingState extends TagsState {}

class TagsPickImageErrorState extends TagsState {
  final String error;
  TagsPickImageErrorState(this.error);
}

class TagsPickImageSuccessState extends TagsState {}

class TagsUploadImageLoadingState extends TagsState {}

class TagsUploadImageErrorState extends TagsState {
  final String error;
  TagsUploadImageErrorState(this.error);
}

class TagsUploadImageSuccessState extends TagsState {}

class TagsDeleteLoadingState extends TagsState {}

class TagsDeleteErrorState extends TagsState {
  final String error;
  TagsDeleteErrorState(this.error);
}

class TagsDeleteSuccessState extends TagsState {}

class TagsGetAllloadingState extends TagsState {}

class TagsGetAllSuccessState extends TagsState {}

class TagsGetAllErrorState extends TagsState {
  final String error;
  TagsGetAllErrorState(this.error);
}

class TagsLoaded extends TagsState {
  final List<TagsModel> tags;

  TagsLoaded(this.tags);

  List<TagsModel> get tagsData => tags;
}
