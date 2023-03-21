// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articlesModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticlesModel _$ArticlesModelFromJson(Map<String, dynamic> json) =>
    ArticlesModel(
      json['body'] as String,
      json['aid'] as String,
      (json['image'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      json['id'] as String,
      json['title'] as String,
    );

Map<String, dynamic> _$ArticlesModelToJson(ArticlesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'aid': instance.aid,
      'image': instance.image,
      'tags': instance.tags,
    };
