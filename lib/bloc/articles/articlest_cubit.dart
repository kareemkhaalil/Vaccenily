import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashborad/data/models/adminModel.dart';
import 'package:dashborad/data/models/articlesModel.dart';
import 'package:file/file.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:meta/meta.dart';

part 'articlest_state.dart';

class ArticlestCubit extends Cubit<ArticlestState> {
  ArticlestCubit() : super(ArticlestInitial());
  AdminModel? adminModel;

  void createArticle({
    required String title,
    required String body,
    required String aid,
    List<String>? image,
    List<String>? tags,
  }) {
    try {
      emit(ArticlestCreatingLoadingState());
      ArticlesModel model = ArticlesModel(
        title: title,
        body: body,
        aid: aid,
        image: image,
        tags: tags,
        uid: adminModel!.uid,
      );
      FirebaseFirestore.instance
          .collection('articles')
          .doc(aid)
          .set(model.toMap());
      emit(ArticlestCreateSuccessState());
    } on FirebaseException catch (e) {
      emit(ArticlestCreateErrorState(e.message!));
      print(e.message);
    }
  }

  //pick image
  File? articlesImageFile;
  var picker = ImagePickerPlugin();
  Future pickImage() async {
    emit(ArticlesPickImageLoadingState());
    final pickedFile = await picker.pickFile();
    if (pickedFile != null) {
      emit(ArticlesPickImageSuccessState());
      articlesImageFile!.path == pickedFile.path.toString();
      print(pickedFile.path.toString());
    } else {
      print('No Image Selected');
      emit(ArticlesPickImageErrorState('No Image Selected'));
    }
  }

  void articlesUploadImages() {
    emit(ArticlesUploadImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('articles')
        .child(articlesImageFile!.path)
        .child('image')
        .putFile(articlesImageFile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateArticle(image: [value]);
        print(value);
        emit(ArticlesUploadImageSuccessState());
      });
    }).catchError((error) {
      emit(ArticlesUploadImageErrorState(error.toString()));
    });
  }

  void updateArticle({
    String? title,
    String? body,
    String? aid,
    List<String>? image,
    List<String>? tags,
  }) {
    try {
      emit(ArticlesUpdateLoadingState());
      ArticlesModel model = ArticlesModel(
        title: title,
        body: body,
        aid: aid,
        image: image,
        tags: tags,
        uid: adminModel!.uid,
      );
      FirebaseFirestore.instance
          .collection('articles')
          .doc(aid)
          .update(model.toMap());
      emit(ArticlesUpdateSuccessState());
    } on FirebaseException catch (e) {
      emit(ArticlesUpdateErrorState(e.message!));
      print(e.message);
    }
  }

  void deleteArticle({
    required String aid,
  }) {
    try {
      emit(ArticlesDeleteLoadingState());
      FirebaseFirestore.instance.collection('articles').doc(aid).delete();
      emit(ArticlesDeleteSuccessState());
    } on FirebaseException catch (e) {
      emit(ArticlesDeleteErrorState(e.message!));
      print(e.message);
    }
  }

  Future<void> getAllArticles() async {
    try {
      emit(ArticlesGetAllLoadingState());
      FirebaseFirestore.instance.collection('articles').get().then((value) {
        List<ArticlesModel> articles = [];
        value.docs.forEach((element) {
          articles.add(ArticlesModel.fromJson(element.data()));
        });
        emit(ArticlesLoaded(articles));
      });
    } on FirebaseException catch (e) {
      emit(ArticlesDeleteErrorState(e.message!));
      print(e.message);
    }
  }

  void getArticleById({
    required String aid,
  }) {
    try {
      emit(ArticlesGetByIdLoadingState());
      FirebaseFirestore.instance
          .collection('articles')
          .doc(aid)
          .get()
          .then((value) {
        ArticlesModel article = ArticlesModel.fromJson(value.data());
        emit(ArticlesGetByIdSuccessState([article]));
      });
    } on FirebaseException catch (e) {
      emit(ArticlesGetByIdErrorState(e.message!));
      print(e.message);
    }
  }

  void getArticleByTag({
    required String tag,
  }) {
    try {
      emit(ArticlesGetByTagLoadingState());
      FirebaseFirestore.instance
          .collection('articles')
          .where('tags', arrayContains: tag)
          .get()
          .then((value) {
        List<ArticlesModel> articles = [];
        value.docs.forEach((element) {
          articles.add(ArticlesModel.fromJson(element.data()));
        });
        emit(ArticlesGetByTagSuccessState(articles));
      });
    } on FirebaseException catch (e) {
      emit(ArticlesGetByTagErrorState(e.message!));
      print(e.message);
    }
  }

  void addTagToArticle({
    required String aid,
    required String tag,
  }) {
    try {
      emit(ArticlesAddTagLoadingState());
      FirebaseFirestore.instance.collection('articles').doc(aid).update({
        'tags': FieldValue.arrayUnion([tag])
      });
      emit(ArticlesAddTagSuccessState());
    } on FirebaseException catch (e) {
      emit(ArticlesAddTagErrorState(e.message!));
      print(e.message);
    }
  }
}
