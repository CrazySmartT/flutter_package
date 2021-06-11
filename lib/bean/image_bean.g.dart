// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageBean _$ImageBeanFromJson(Map<String, dynamic> json) {
  return ImageBean(
    json['image'] as String,
    json['title'] as String,
    json['type'] as int,
    json['urlschema'] as String,
  );
}

Map<String, dynamic> _$ImageBeanToJson(ImageBean instance) => <String, dynamic>{
      'image': instance.image,
      'urlschema': instance.urlschema,
      'title': instance.title,
      'type': instance.type,
    };
