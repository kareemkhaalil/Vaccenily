// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tagsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagsModel _$TagsModelFromJson(Map<String, dynamic> json) => TagsModel(
      json['id'] as String,
      json['title'] as String,
      json['image'] as String,
      json['aId'] as String,
      json['articleCount'] as int,
    );

Map<String, dynamic> _$TagsModelToJson(TagsModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'aId': instance.aId,
      'articleCount': instance.articleCount,
    };
