import 'package:bloc/bloc.dart';
import 'package:dashborad/data/models/articlesModel.dart';
import 'package:dashborad/data/remote/repo.dart';
import 'package:file/file.dart';
import 'package:flutter/material.dart';

import 'package:mime/mime.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:universal_html/html.dart' as uni;

part 'articlest_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  final Repository _repository;

  ArticlesCubit(this._repository) : super(ArticlesInitial());

  List<Map<String, dynamic>> droppedItems = [];
  final QuillEditorController controller = QuillEditorController();
  final customToolBarList = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.align,
    ToolBarStyle.color,
  ];

  String? currentItem;
  dropingItems(Map<String, dynamic> data) {
    emit(ArticleDropLoading());
    droppedItems.add(data);
    emit(ArticleDropSuccess());
  }

  void reorderItems(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = droppedItems.removeAt(oldIndex);
    droppedItems.insert(newIndex, item);
    emit(ArticlesUpdated());
  }

  Widget defaultEmbedBuilderWeb(BuildContext context, dynamic node) {
    final String imageUrl = node.attributes['src'] as String;
    final double? width = node.attributes['width'] as double?;
    final double? height = node.attributes['height'] as double?;
    final BoxFit fit = BoxFit.cover;

    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
    );
  }

  Future<void> getAllArticles() async {
    emit(ArticlesLoading());

    try {
      List<ArticlesModel> articles = await _repository.getAllArticles();
      emit(ArticlesLoaded(articles));
    } catch (e) {
      emit(ArticlesError(e.toString()));
    }
  }

  void setCurrentItem(String item) {
    currentItem = item;
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
