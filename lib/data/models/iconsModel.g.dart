// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iconsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IconsModel _$IconsModelFromJson(Map<String, dynamic> json) => IconsModel(
      json['id'] as String,
      json['iconUrl'] as String,
      json['iconTitle'] as String?,
      json['articleCount'] as int,
      json['aId'] as String?,
    );

Map<String, dynamic> _$IconsModelToJson(IconsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'iconUrl': instance.iconUrl,
      'iconTitle': instance.iconTitle,
      'articleCount': instance.articleCount,
      'aId': instance.aId,
    };
