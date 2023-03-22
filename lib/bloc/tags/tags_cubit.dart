import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashborad/data/models/adminModel.dart';
import 'package:dashborad/data/models/tagsModel.dart';
import 'package:file/file.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:meta/meta.dart';

part 'tags_state.dart';

class TagsCubit extends Cubit<TagsState> {
  TagsCubit() : super(TagsInitial());
  AdminModel? adminModel;
  void createTag({
    required String name,
    required String tid,
    List<String>? postsUid,
  }) {
    // try {
    //   emit(TagsCreatingLoadingState());
    //   TagsModel model = TagsModel(
    //     title: name,
    //     tid: tid,
    //     postsUid: [],
    //   );
    //   FirebaseFirestore.instance.collection('tags').doc(tid).set(model.toMap());
    //   emit(TagsCreateSuccessState());
    // } on FirebaseException catch (e) {
    //   emit(TagsCreateErrorState(e.message!));
    //   print(e.message);
    // }
  }

  void deleteTag({
    required String tid,
  }) {
    try {
      emit(TagsDeleteLoadingState());
      FirebaseFirestore.instance.collection('tags').doc(tid).delete();
      emit(TagsDeleteSuccessState());
    } on FirebaseException catch (e) {
      emit(TagsDeleteErrorState(e.message!));
      print(e.message);
    }
  }

  TagsModel? model;
  void getTagsData(tid) {
    try {
      emit(TagsGetloadingState());
      FirebaseFirestore.instance
          .collection('tags')
          .doc(tid)
          .get()
          .then((value) {
        model = TagsModel.fromJson(value.data()!);
        print(model!.title);
        emit(TagsGetSuccessState());
      });
    } on FirebaseException catch (e) {
      print(e.message);
      emit(TagsGetErrorState(e.message!));
    }
  }

  Future<void> getAllTagsData() async {
    if (!this.isClosed) {
      try {
        emit(TagsGetAllloadingState());
        FirebaseFirestore.instance.collection('tags').get().then((value) {
          List<TagsModel> tags = [];
          value.docs.forEach((element) {
            tags.add(TagsModel.fromJson(element.data()));
          });
          emit(TagsLoaded(tags));
        });
      } on FirebaseException catch (e) {
        print(e.message);
        emit(TagsGetAllErrorState(e.message!));
      }
    }
  }

//pick image
  File? tagImageFile;
  var picker = ImagePickerPlugin();
  Future pickImage() async {
    emit(TagsPickImageLoadingState());
    final pickedFile = await picker.pickFile();
    if (pickedFile != null) {
      emit(TagsPickImageSuccessState());
      tagImageFile!.path == pickedFile.path.toString();
      print(pickedFile.path.toString());
    } else {
      print('No Image Selected');
      emit(TagsPickImageErrorState('No Image Selected'));
    }
  }

  //uploadImageFireBase

  void uploadProfileImage({
    required String name,
  }) {
    try {
      emit(TagsUploadImageLoadingState());
      FirebaseStorage.instance
          .ref()
          .child('tags/${Uri.file(tagImageFile!.path).pathSegments.last}')
          .putFile(tagImageFile!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          print(value);
          updateTag(
            name: name,
            image: value,
          );
          emit(TagsUploadImageSuccessState());
        });
      });
    } on FirebaseException catch (e) {
      emit(TagsUploadImageErrorState(e.message!));
    }
  }

  void updateTag({
    required String name,
    String? image,
  }) {
    // emit(SocialUpdateLoadingState());
    // TagsModel modelMap = TagsModel(
    //   title: name,
    //   image: image,
    //   tid: model!.tid,
    //   postsUid: model!.postsUid,
    // );
    // FirebaseFirestore.instance
    //     .collection('tags')
    //     .doc(model!.tid)
    //     .update(modelMap.toMap())
    //     .then((value) {
    //   getTagsData(model!.tid);
    // });
  }

  void getTagsDataByTitle(title) {
    try {
      emit(TagsGetloadingState());
      FirebaseFirestore.instance
          .collection('tags')
          .where('title', isEqualTo: title)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          model = TagsModel.fromJson(element.data());
          print(model!.title);
        });
        emit(TagsGetSuccessState());
      });
    } on FirebaseException catch (e) {
      print(e.message);
      emit(TagsGetErrorState(e.message!));
    }
  }

  void getTagsDataByAdminId(adminId) {
    try {
      emit(TagsGetloadingState());
      FirebaseFirestore.instance
          .collection('tags')
          .where(
            'uid',
            isEqualTo: adminId,
          )
          .get()
          .then((value) {
        value.docs.forEach((element) {
          model = TagsModel.fromJson(element.data());
          print(model!.title);
        });
        emit(TagsGetSuccessState());
      });
    } on FirebaseException catch (e) {
      print(e.message);
      emit(TagsGetErrorState(e.message!));
    }
  }
}
