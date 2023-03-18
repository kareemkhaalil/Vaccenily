// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adminModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminModel _$AdminModelFromJson(Map<String, dynamic> json) => AdminModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      image: json['image'] as String,
      postsCount: json['postsCount'] as int,
      tagsCount: json['tagsCount'] as int,
      iconssCount: json['iconssCount'] as int,
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
