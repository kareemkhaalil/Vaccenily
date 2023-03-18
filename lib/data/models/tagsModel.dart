import 'package:json_annotation/json_annotation.dart';

part 'tagsModel.g.dart';

@JsonSerializable(explicitToJson: true)
class TagsModel {
  final String id;
  final String title;
  final String image;
  final String aId;
  final int articleCount;

  TagsModel(this.id, this.title, this.image, this.aId, this.articleCount);

  factory TagsModel.fromJson(Map<String, dynamic> json) =>
      _$TagsModelFromJson(json);

  Map<String, dynamic> toJson() => _$TagsModelToJson(this);
}
