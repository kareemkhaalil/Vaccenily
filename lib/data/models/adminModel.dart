import 'package:json_annotation/json_annotation.dart';

part 'adminModel.g.dart';

@JsonSerializable(explicitToJson: true)
class AdminModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String image;
  final int postsCount;
  final int tagsCount;
  final int iconssCount;

  AdminModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.image,
      required this.postsCount,
      required this.tagsCount,
      required this.iconssCount});

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
