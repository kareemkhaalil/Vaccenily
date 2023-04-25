import 'package:json_annotation/json_annotation.dart';

part 'adminModel.g.dart';

@JsonSerializable(explicitToJson: true)
class AdminModel {
  String? id;
  String? name;
  String? email;
  String? password;
  String? image;
  int? postsCount;
  int? tagsCount;
  int? iconssCount;

  AdminModel(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.image,
      this.postsCount,
      this.tagsCount,
      this.iconssCount});

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      image: json['image'] ?? '',
      postsCount: json['postsCount'] ?? 0,
      tagsCount: json['tagsCount'] ?? 0,
      iconssCount: json['iconssCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => _$AdminModelToJson(this);
}
