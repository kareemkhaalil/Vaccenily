class TagsModel {
  String? title;
  String? tid;
  String? uid;
  String? image;
  List<String>? postsUid;

  TagsModel({
    this.title,
    this.tid,
    this.image,
    this.postsUid,
    this.uid,
  });
  TagsModel.fromJson(Map<String, dynamic>? json) {
    title = json?['title'];
    tid = json?['tid'];
    image = json?['image'];
    postsUid = json?['postsUid'];
    uid = json?['uid'];
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'tid': tid,
      'image': image,
      'postsUid': postsUid,
      'uid': uid,
    };
  }
}
