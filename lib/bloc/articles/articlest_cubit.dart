import 'package:bloc/bloc.dart';
import 'package:dashborad/data/models/articlesModel.dart';
import 'package:dashborad/data/remote/repo.dart';
import 'package:file/file.dart';
import 'package:flutter/material.dart';

part 'articlest_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  final Repository _repository;

  ArticlesCubit(this._repository) : super(ArticlesInitial());
  Future<void> getAllArticles() async {
    emit(ArticlesLoading());

    try {
      List<ArticlesModel> articles = await _repository.getAllArticles();
      emit(ArticlesLoaded(articles));
    } catch (e) {
      emit(ArticlesError(e.toString()));
    }
  }

  Future<void> getArticlesByAdminId() async {
    emit(ArticlesLoading());

    try {
      List<ArticlesModel> articles = await _repository.getArticlesByAdminId();
      emit(ArticlesLoaded(articles));
    } catch (e) {
      emit(ArticlesError(e.toString()));
    }
  }

  Future<void> addArticle(ArticlesModel article, [File? imageFile]) async {
    emit(ArticlesLoading());

    try {
      if (imageFile != null) {
        String imageUrl = await _repository.uploadArticleImage(imageFile);
        article = article.copyWith(image: [...(article.image ?? []), imageUrl]);
      }
      await _repository.addArticle(
        article,
        article.tags,
      );
      emit(ArticlesActionSuccess());
    } catch (e) {
      emit(ArticlesError(e.toString()));
    }
  }

  Future<void> updateArticle(ArticlesModel article, [File? imageFile]) async {
    emit(ArticlesLoading());

    try {
      if (imageFile != null) {
        String imageUrl = await _repository.uploadArticleImage(imageFile);
        article = article.copyWith(image: [...(article.image ?? []), imageUrl]);
      }
      await _repository.updateArticle(
        article.id,
        article,
      );
      emit(ArticlesActionSuccess());
    } catch (e) {
      emit(ArticlesError(e.toString()));
    }
  }

  Future<void> deleteArticle(String articleId) async {
    emit(ArticlesLoading());

    try {
      await _repository.deleteArticle(articleId);
      emit(ArticlesActionSuccess());
    } catch (e) {
      emit(ArticlesError(e.toString()));
    }
  }
}
