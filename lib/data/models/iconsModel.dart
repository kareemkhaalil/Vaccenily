class IconsModel {
  String? title;
  String? iId;
  String? image;
  String? uid;
  Map<String, dynamic>? posts;
  IconsModel({
    this.title,
    this.iId,
    this.image,
    this.posts,
    this.uid,
  });

  IconsModel.fromJson(Map<String, dynamic>? json) {
    title = json?['title'];
    iId = json?['iId'];
    image = json?['image'];
    posts = json?['posts'];
    uid = json?['uid'];
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'iId': iId,
      'image': image,
      'posts': posts,
      'uid': uid,
    };
  }
}
