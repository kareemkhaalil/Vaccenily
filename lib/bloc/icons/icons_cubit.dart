import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashborad/data/models/iconsModel.dart';
import 'package:file/file.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:meta/meta.dart';
import 'package:universal_html/html.dart' as html;

part 'icons_state.dart';

class IconsCubit extends Cubit<IconsState> {
  IconsCubit() : super(IconsInitial());

  Future<void> getIconsData() async {
    if (!this.isClosed) {
      try {
        emit(IconsGetloadingState());
        FirebaseFirestore.instance.collection('icons').get().then((value) {
          List<IconsModel> icons = [];
          value.docs.forEach((element) {
            icons.add(IconsModel.fromJson(element.data()));
          });
          emit(IconsLoaded(icons));
        });
      } on FirebaseException catch (e) {
        print(e.message);
        emit(IconsGetErrorState(e.message!));
      }
    }
  }

  void createIcon({
    required String? title,
    required String? image,
    required String? iId,
  }) {
    // try {
    //   emit(IconsCreatingLoadingState());
    //   IconsModel model = IconsModel(
    //     title: title,
    //     image: image,
    //     iId: iId,
    //   );
    //   FirebaseFirestore.instance
    //       .collection('icons')
    //       .doc(iId)
    //       .set(model.toMap());
    //   emit(IconsCreateSuccessState());
    // } on FirebaseException catch (e) {
    //   emit(IconsCreateErrorState(e.message!));
    //   print(e.message);
    // }
  }

  void deleteIcon({
    required String iId,
  }) {
    try {
      emit(IconsDeleteLoadingState());
      FirebaseFirestore.instance.collection('icons').doc(iId).delete();
      emit(IconsDeleteSuccessState());
    } on FirebaseException catch (e) {
      emit(IconsDeleteErrorState(e.message!));
      print(e.message);
    }
  }

  IconsModel? model;

  void updateIcon({
    required String title,
    required String image,
    required String iId,
  }) {
    // try {
    //   emit(IconsUpdateLoadingState());
    //   IconsModel model = IconsModel(
    //     title: title,
    //     image: image,
    //     iId: iId,
    //   );
    //   FirebaseFirestore.instance
    //       .collection('icons')
    //       .doc(iId)
    //       .update(model.toMap());
    //   emit(IconsUpdateSuccessState());
    // } on FirebaseException catch (e) {
    //   emit(IconsUpdateErrorState(e.message!));
    //   print(e.message);
    // }
  }

  var picker = ImagePickerPlugin();
  html.File? image;
  Future<void> pickImage() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final file = uploadInput.files!.first;
      final reader = html.FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        image = file;
      });
    });
  }

  void iconsUploadImages() {
    // emit(IconsUploadImageLoadingState());
    // FirebaseStorage.instance
    //     .ref()
    //     .child('icons')
    //     .child(model!.iId!)
    //     .child('image')
    //     .putFile(articlesImageFile!)
    //     .then(
    //   (value) {
    //     value.ref.getDownloadURL().then((value) {
    //       print(value);
    //       createIcon(
    //         title: model!.title,
    //         image: value,
    //         iId: model!.iId,
    //       );
    //     });
    //   },
    // );
  }

  void getIconsDataById({
    required String iId,
  }) {
    try {
      emit(IconsGetByIdLoadingState());
      FirebaseFirestore.instance
          .collection('icons')
          .doc(iId)
          .get()
          .then((value) {
        model = IconsModel.fromJson(value.data()!);
        emit(IconsGetByIdSuccessState());
      });
    } on FirebaseException catch (e) {
      emit(IconsGetByIdErrorState(e.message!));
      print(e.message);
    }
  }
}
