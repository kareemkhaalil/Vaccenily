class AdminModel {
  String? name;
  String? email;
  String? uid;
  String? image;
  double? postsCount;

  AdminModel({
    this.name,
    this.email,
    this.uid,
    this.image,
    this.postsCount,
  });

  AdminModel.fromJson(Map<String, dynamic>? json) {
    name = json?['name'];
    email = json?['email'];
    uid = json?['uid'];
    image = json?['image'];
    postsCount = json?['postsCount'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'image': image,
      'postsCount': postsCount,
    };
  }
}
