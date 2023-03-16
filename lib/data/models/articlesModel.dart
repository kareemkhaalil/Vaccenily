class ArticlesModel {
  String? title;
  String? body;
  String? aid;
  String? uid;
  List<String>? image;
  List<String>? tags;

  ArticlesModel({
    this.title,
    this.body,
    this.aid,
    this.image,
    this.tags,
    this.uid,
  });

  ArticlesModel.fromJson(Map<String, dynamic>? json) {
    title = json?['title'];
    body = json?['body'];
    aid = json?['aid'];
    image = json?['image'];
    tags = json?['tags'];
    uid = json?['uid'];
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'aid': aid,
      'image': image,
      'tags': tags,
      'uid': uid,
    };
  }
}
