import 'package:web_app/service/base_entity.dart';

class ColorProductModel extends BaseEntity {
  int? status;
  List<Color>? color;
  int? totalPages;

  ColorProductModel({this.status, this.color});

  ColorProductModel.fromJson(Map<dynamic, dynamic> json) {
    super.mapping(json);
    status = json['status'];
    if (json['data'] != null) {
      color = <Color>[];
      json['data'].forEach((v) {
        color!.add(Color.fromJson(v));
      });
    }
  }
}

class Color extends BaseEntity {
  int? id;
  String? name;

  Color({this.id, this.name});

  Color.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
