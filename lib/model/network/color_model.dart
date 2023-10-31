import 'package:web_app/service/base_entity.dart';

class ColorProductModel extends BaseEntity {
  int? status;
  List<ColorShoe>? color;
  int? totalPages;

  ColorProductModel({this.status, this.color});

  ColorProductModel.fromJson(Map<dynamic, dynamic> json) {
    // super.mapping(json);
    status = json['status'];
    if (json['data'] != null) {
      color = <ColorShoe>[];
      json['data'].forEach((v) {
        color!.add(ColorShoe.fromJson(v));
      });
    }
  }
}

class ColorShoe extends BaseEntity {
  int? id;
  String? name;
  String? colorCode;

  ColorShoe({this.id, this.name, this.colorCode});

  ColorShoe.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    colorCode = json['color_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['color_code'] = colorCode;
    return data;
  }
}
