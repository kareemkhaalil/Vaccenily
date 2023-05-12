part of 'articlest_cubit.dart';

abstract class ArticlesState {}

class ArticlesInitial extends ArticlesState {}

class ArticlesLoading extends ArticlesState {}

class ArticlesSuccess extends ArticlesState {
  final List<ArticlesModel> articles;

  ArticlesSuccess(this.articles);
}

class ArticlesFailure extends ArticlesState {
  final String message;

  ArticlesFailure(this.message);
}

class ArticlesLoaded extends ArticlesState {
  final List<ArticlesModel> articles;

  ArticlesLoaded(this.articles);
}

class ArticlesError extends ArticlesState {
  final String message;

  ArticlesError(this.message);
}

class ArticlesActionSuccess extends ArticlesState {}

class ArticleDropLoading extends ArticlesState {}

class ArticleDropSuccess extends ArticlesState {}

class ArticleDropFailure extends ArticlesState {}

class ArticlesUpdated extends ArticlesState {}
