import 'package:json_annotation/json_annotation.dart';

part 'articlesModel.g.dart';

@JsonSerializable(explicitToJson: true)
class ArticlesModel {
  final String id;
  final String title;
  final String body;
  final String aid;
  final List<String>? image;
  List<String> tags;
  ArticlesModel copyWith({
    String? id,
    String? title,
    String? body,
    String? aid,
    List<String>? image,
    List<String>? tags,
  }) {
    return ArticlesModel(
      body ?? this.body,
      aid ?? this.aid,
      image ?? this.image,
      tags ?? this.tags,
      id ?? this.id,
      title ?? this.title,
    );
  }

  ArticlesModel(
      this.body, this.aid, this.image, this.tags, this.id, this.title);

  factory ArticlesModel.fromJson(Map<String, dynamic> json) =>
      _$ArticlesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticlesModelToJson(this);
}
