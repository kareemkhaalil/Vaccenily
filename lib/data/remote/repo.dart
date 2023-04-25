import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file/file.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:universal_html/html.dart' as html;

import 'package:dashborad/data/models/adminModel.dart';
import 'package:dashborad/data/models/articlesModel.dart';
import 'package:dashborad/data/models/iconsModel.dart';
import 'package:dashborad/data/models/tagsModel.dart';
import 'package:dashborad/data/remote/authRepo.dart';
import 'package:dashborad/data/remote/fireAuth.dart';

class Repository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final AuthRepository _authRepository = AuthRepository();

  /// Admin Functions ///
  // إضافة مشرف جديد
  Future<void> addAdmin(AdminModel admin) async {
    try {
      print("calling addAdmin()");
      // إنشاء مستخدم جديد باستخدام البريد الإلكتروني وكلمة المرور الموجودة في الكائن admin
      User? newUser = await _authRepository.createUserWithEmailAndPassword(
          admin.email!, admin.password!);

      if (admin.email == null) {
        print("email is null");
      } else {
        print(admin.email);
      }

      if (admin.password == null) {
        print("password is null");
      } else {
        print(admin.password);
      }

      // التحقق من أن newUser ليس null
      if (newUser != null) {
        // الحصول على معرف المستخدم الجديد
        String userId = newUser.uid;

        // إضافة معرف المستخدم إلى كائن AdminModel
        admin.id = userId;

        // إضافة بيانات الكائن admin إلى مجموعة 'admins' في Firestore واستخدام معرف المستخدم كمعرف الوثيقة
        await _firestore.collection('admins').doc(userId).set(admin.toJson());
      } else {
        throw Exception("Model is null");
      }
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  // تحديث بيانات مشرف
  Future<void> updateAdmin(AdminModel admin) async {
    // تنفيذ العملية هنا
  }

  // حذف مشرف
  Future<void> deleteAdmin(String adminId) async {
    // تأكيد وجود معرّف المشرف
    if (adminId == null) {
      throw Exception('معرّف المشرف غير موجود');
    }

    // الحصول على مرجع المستند المطلوب حذفه
    DocumentReference adminDocRef =
        _firestore.collection('admins').doc(adminId);

    // حذف المستند من Firestore
    await adminDocRef.delete();
  }

  // استدعاء كل بيانات المشرفين
  Future<List<AdminModel>> getAllAdmins() async {
    QuerySnapshot querySnapshot = await _firestore.collection('admins').get();
    return querySnapshot.docs
        .map((doc) => AdminModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // استدعاء بيانات المشرف الذي سجل دخوله في التطبيق حالا
  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserData(
      String email) async {
    try {
      DocumentReference userRef = _firestore.collection('users').doc(email);
      DocumentSnapshot<Map<String, dynamic>>? userDoc =
          (await userRef.get()) as DocumentSnapshot<Map<String, dynamic>>?;

      if (userDoc!.exists) {
        return userDoc;
      } else {
        return null;
      }
    } catch (e) {
      // يمكنك التعامل مع الأخطاء هنا
      return null;
    }
  }

  Future<AdminModel?> getCurrentAdmin(String adminId) async {
    // تأكيد وجود معرّف المشرف
    try {
      if (adminId == null) {
        throw Exception('معرّف المشرف غير موجود');
      }
      // الحصول على مرجع المستند المطلوب استرجاعه
      DocumentReference adminDocRef =
          _firestore.collection('admins').doc(adminId);

      // استرجاع المستند من Firestore
      DocumentSnapshot adminDoc = await adminDocRef.get();

      // التحقق من وجود المستند
      if (!adminDoc.exists) {
        throw Exception('المشرف غير موجود');
      }

      // تحويل البيانات إلى كائن AdminModel
      AdminModel admin =
          AdminModel.fromJson(adminDoc.data() as Map<String, dynamic>);

      // إرجاع كائن المشرف
      return admin;
    } on Exception catch (e) {
      print("getCurrentAdmin error is $e");
      return null;
    }
  }

  Future<String> uploadAdminImage(html.File? imageFile, String userId) async {
    String fileName = 'admins/${DateTime.now().toIso8601String()}.png';
    Reference ref = _storage.ref().child(fileName);

    final reader = html.FileReader();
    final completer = Completer<Uint8List>();

    reader.readAsArrayBuffer(imageFile!);
    reader.onLoadEnd.listen((event) {
      completer.complete(Uint8List.fromList(reader.result as List<int>));
    });

    final imageData = await completer.future;
    UploadTask uploadTask = ref.putData(imageData);

    // انتظر حتى تكتمل عملية الرفع
    TaskSnapshot taskSnapshot = await uploadTask;

    // احصل على رابط الصورة الموجودة في Firebase Storage

    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    await _firestore
        .collection('admins')
        .doc(userId)
        .update({'image': imageUrl});

    return imageUrl;
  }

  /// Article Fubctions ///
  Future<void> addArticle(ArticlesModel article, List<String> tags) async {
    // تحديث كائن المقالة بالوسوم المرتبطة به
    article.tags = tags;

    // إضافة المقالة
    await _firestore.collection('articles').add(article.toJson());
  }

  // تحديث مقال
  Future<void> updateArticle(
      String articleId, ArticlesModel updatedArticle) async {
    await _firestore
        .collection('articles')
        .doc(articleId)
        .update(updatedArticle.toJson());
  }

  // حذف مقال
  Future<void> deleteArticle(String articleId) async {
    await _firestore.collection('articles').doc(articleId).delete();
  }

  // استدعاء كل المقالات
  Future<List<ArticlesModel>> getAllArticles() async {
    QuerySnapshot querySnapshot = await _firestore.collection('articles').get();
    return querySnapshot.docs
        .map(
            (doc) => ArticlesModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // استدعاء كل المقالات على حسب الid الخاص بالمشرف
  Future<List<ArticlesModel>> getArticlesByAdminId() async {
    User? currentUser = getCurrentUser();

    if (currentUser == null) {
      return [];
    }
    String adminId = currentUser.uid;

    QuerySnapshot querySnapshot = await _firestore
        .collection('articles')
        .where('adminId', isEqualTo: adminId)
        .get();
    return querySnapshot.docs
        .map(
            (doc) => ArticlesModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // استدعاء كل المقالات على حسب الid الخاص بالtag
  Future<List<ArticlesModel>> getArticlesByTagId(String tagId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('articles')
        .where('tagId', isEqualTo: tagId)
        .get();
    return querySnapshot.docs
        .map(
            (doc) => ArticlesModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // استدعاء كل المقالات على حسب ال id الخاص بالicon
  Future<List<ArticlesModel>> getArticlesByIconId(String iconId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('articles')
        .where('iconId', isEqualTo: iconId)
        .get();
    return querySnapshot.docs
        .map(
            (doc) => ArticlesModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<String> uploadArticleImage(File imageFile) async {
    String fileName = 'articles/${DateTime.now().toIso8601String()}.png';
    Reference ref = _storage.ref().child(fileName);
    UploadTask uploadTask = ref.putFile(imageFile);

    // انتظر حتى تكتمل عملية الرفع
    TaskSnapshot taskSnapshot = await uploadTask;

    // احصل على رابط الصورة الموجودة في Firebase Storage
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }

  /// Icons Functions ///

// 1. إنشاء أيقونة جديدة
  Future<void> createIcon(IconsModel icon) async {
    await _firestore.collection('icons').add(icon.toJson());
  }

// 2. تحديث بيانات الأيقونة
  Future<void> updateIcon(IconsModel icon) async {
    await _firestore.collection('icons').doc(icon.id).update(icon.toJson());
  }

// 3. حذف الأيقونة
  Future<void> deleteIcon(String iconId) async {
    await _firestore.collection('icons').doc(iconId).delete();
  }

// 4. رفع صورة الأيقونة
  Future<String> uploadIconImage(File imageFile) async {
    String fileName = 'icons/${DateTime.now().millisecondsSinceEpoch}.jpg';
    UploadTask uploadTask = _storage.ref(fileName).putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

// 5. استدعاء كل الأيقونات
  Future<List<IconsModel>> getAllIcons() async {
    QuerySnapshot snapshot = await _firestore.collection('icons').get();
    return snapshot.docs
        .map((doc) => IconsModel.fromJsonWithId(
            doc.id, doc.data() as Map<String, dynamic>))
        .toList();
  }

// 6. استدعاء كل الأيقونات على حسب الفئات المختلفة
  Future<List<IconsModel>> getIconsByAdminId() async {
    User? currentUser = getCurrentUser();

    if (currentUser == null) {
      return [];
    }
    String adminId = currentUser.uid;

    QuerySnapshot snapshot = await _firestore
        .collection('icons')
        .where('adminsId', isEqualTo: adminId)
        .get();
    return snapshot.docs
        .map((doc) => IconsModel.fromJsonWithId(
            doc.id, doc.data() as Map<String, dynamic>))
        .toList();
  }

  /// Tags Functions ///
// 1. إنشاء تاج جديد
  Future<void> createTag(TagsModel tag) async {
    await _firestore.collection('tags').add(tag.toJson());
  }

// 2. تعديل بيانات التاج
  Future<void> updateTag(TagsModel tag) async {
    await _firestore.collection('tags').doc(tag.id).update(tag.toJson());
  }

// 3. حذف التاج
  Future<void> deleteTag(String tagId) async {
    await _firestore.collection('tags').doc(tagId).delete();
  }

// 4. استدعاء كل التاجز
  Future<List<TagsModel>> getAllTags() async {
    QuerySnapshot snapshot = await _firestore.collection('tags').get();
    return snapshot.docs
        .map((doc) => TagsModel.fromJsonWithId(
            doc.id, doc.data() as Map<String, dynamic>))
        .toList();
  }

// 5. استدعاء كل التاجز على حسب ال id الخاص بالمشرف
  Future<List<TagsModel>> getTagsByAdmin(String adminId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('tags')
        .where('adminId', isEqualTo: adminId)
        .get();
    return snapshot.docs
        .map((doc) => TagsModel.fromJsonWithId(
            doc.id, doc.data() as Map<String, dynamic>))
        .toList();
  }

// 6. استدعاء كل التاجز على حسب ال id الخاص بالمقالة
  Future<List<TagsModel>> getTagsByArticle(String articleId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('tags')
        .where('articleId', isEqualTo: articleId)
        .get();
    return snapshot.docs
        .map((doc) => TagsModel.fromJsonWithId(
            doc.id, doc.data() as Map<String, dynamic>))
        .toList();
  }

// 7. استدعاء كل التاجز على حسب ال id الخاص بالأيقونة
  Future<List<TagsModel>> getTagsByIcon(String iconId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('tags')
        .where('iconId', isEqualTo: iconId)
        .get();
    return snapshot.docs
        .map((doc) => TagsModel.fromJsonWithId(
            doc.id, doc.data() as Map<String, dynamic>))
        .toList();
  }

  /// ِAuth ///
  User? getCurrentUser() {
    return _authRepository.getCurrentUser();
  }
}
