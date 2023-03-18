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

  AdminModel(this.id, this.name, this.email, this.password, this.image,
      this.postsCount, this.tagsCount, this.iconssCount);

  factory AdminModel.fromJson(Map<String, dynamic> json) =>
      _$AdminModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdminModelToJson(this);
}
