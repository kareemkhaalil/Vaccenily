part of 'articlest_cubit.dart';

@immutable
abstract class ArticlestState {}

class ArticlestInitial extends ArticlestState {}

class ArticlestCreatingLoadingState extends ArticlestState {}

class ArticlestCreateSuccessState extends ArticlestState {}

class ArticlestCreateErrorState extends ArticlestState {
  final String error;
  ArticlestCreateErrorState(this.error);
}

class ArticlesUpdateLoadingState extends ArticlestState {}

class ArticlesUpdateSuccessState extends ArticlestState {}

class ArticlesUpdateErrorState extends ArticlestState {
  final String error;
  ArticlesUpdateErrorState(this.error);
}

class ArticlesDeleteLoadingState extends ArticlestState {}

class ArticlesDeleteSuccessState extends ArticlestState {}

class ArticlesDeleteErrorState extends ArticlestState {
  final String error;
  ArticlesDeleteErrorState(this.error);
}

class ArticlesGetAllLoadingState extends ArticlestState {}

class ArticlesGetAllSuccessState extends ArticlestState {
  final List<ArticlesModel> articles;
  ArticlesGetAllSuccessState(this.articles);
}

class ArticlesGetAllErrorState extends ArticlestState {
  final String error;
  ArticlesGetAllErrorState(this.error);
}

class ArticlesGetByIdLoadingState extends ArticlestState {}

class ArticlesGetByIdSuccessState extends ArticlestState {
  final List<ArticlesModel> articles;
  ArticlesGetByIdSuccessState(this.articles);
}

class ArticlesGetByIdErrorState extends ArticlestState {
  final String error;
  ArticlesGetByIdErrorState(this.error);
}

class ArticlesPickImageLoadingState extends ArticlestState {}

class ArticlesPickImageSuccessState extends ArticlestState {}

class ArticlesPickImageErrorState extends ArticlestState {
  final String error;
  ArticlesPickImageErrorState(this.error);
}

class ArticlesUploadImageLoadingState extends ArticlestState {}

class ArticlesUploadImageSuccessState extends ArticlestState {}

class ArticlesUploadImageErrorState extends ArticlestState {
  final String error;
  ArticlesUploadImageErrorState(this.error);
}

class ArticlesGetByTagLoadingState extends ArticlestState {}

class ArticlesGetByTagSuccessState extends ArticlestState {
  final List<ArticlesModel> articles;
  ArticlesGetByTagSuccessState(this.articles);
}

class ArticlesGetByTagErrorState extends ArticlestState {
  final String error;
  ArticlesGetByTagErrorState(this.error);
}

class ArticlesAddTagLoadingState extends ArticlestState {}

class ArticlesAddTagSuccessState extends ArticlestState {}

class ArticlesAddTagErrorState extends ArticlestState {
  final String error;
  ArticlesAddTagErrorState(this.error);
}

class ArticlesLoaded extends ArticlestState {
  final List<ArticlesModel> articles;

  ArticlesLoaded(this.articles);

  List<ArticlesModel> get articlesData => articles;
}
