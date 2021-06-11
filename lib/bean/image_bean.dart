
import 'package:json_annotation/json_annotation.dart';
part 'image_bean.g.dart';

@JsonSerializable()
class ImageBean{
  String image;
  String urlschema;
  String title;
  int type;

  ImageBean(this.image,this.title,this.type,this.urlschema);

  factory ImageBean.fromJson(Map<String, dynamic> json) => _$ImageBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ImageBeanToJson(this);
}