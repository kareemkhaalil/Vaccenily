import 'package:json_annotation/json_annotation.dart';

part 'articlesModel.g.dart';

@JsonSerializable(explicitToJson: true)
class ArticlesModel {
  final String id;
  final String title;
  final String body;
  final String aid;
  final List<String>? image;
  final List<String>? tags;

  ArticlesModel(
      this.body, this.aid, this.image, this.tags, this.id, this.title);

  factory ArticlesModel.fromJson(Map<String, dynamic> json) =>
      _$ArticlesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticlesModelToJson(this);
}
