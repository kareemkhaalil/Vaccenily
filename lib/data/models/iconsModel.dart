import 'package:json_annotation/json_annotation.dart';

part 'iconsModel.g.dart';

@JsonSerializable(explicitToJson: true)
class IconsModel {
  final String id;
  final String iconUrl;
  final String? iconTitle;
  final int articleCount;
  final String? aId;

  IconsModel(
    this.id,
    this.iconUrl,
    this.iconTitle,
    this.articleCount,
    this.aId,
  );

  factory IconsModel.fromJson(Map<String, dynamic> json) =>
      _$IconsModelFromJson(json);

  factory IconsModel.fromJsonWithId(String id, Map<String, dynamic> json) =>
      IconsModel(
        id,
        json['iconUrl'] as String,
        json['iconTitle'] as String?,
        json['articleCount'] as int,
        json['aId'] as String?,
      );

  Map<String, dynamic> toJson() => _$IconsModelToJson(this);
}
