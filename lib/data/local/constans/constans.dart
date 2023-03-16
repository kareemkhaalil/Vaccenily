class Constants {
  static const String articlesCollection = 'articles';
  static const String iconsCollection = 'icons';
  static const String tagsCollection = 'tags';
  late Map? allAdmins;
  Map get getAllAdmins => allAdmins!;
  Map<String, dynamic> adminData = {};
  String? adminUID;
}
