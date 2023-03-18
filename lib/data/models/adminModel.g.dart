// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adminModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminModel _$AdminModelFromJson(Map<String, dynamic> json) => AdminModel(
      json['id'] as String,
      json['name'] as String,
      json['email'] as String,
      json['password'] as String,
      json['image'] as String,
      json['postsCount'] as int,
      json['tagsCount'] as int,
      json['iconssCount'] as int,
    );

Map<String, dynamic> _$AdminModelToJson(AdminModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'image': instance.image,
      'postsCount': instance.postsCount,
      'tagsCount': instance.tagsCount,
      'iconssCount': instance.iconssCount,
    };
