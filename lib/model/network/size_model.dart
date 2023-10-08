import 'package:web_app/service/base_entity.dart';

class SizeProductModel extends BaseEntity {
  int? status;
  int? totalPages;
  List<Size>? size;

  SizeProductModel({this.status, this.size});

  SizeProductModel.fromJson(Map<dynamic, dynamic> json) {
    super.mapping(json);
    status = json['status'];
    if (json['data'] != null) {
      size = <Size>[];
      json['data'].forEach((v) {
        size!.add(Size.fromJson(v));
      });
    }
  }
}

class Size extends BaseEntity {
  int? id;
  String? name;

  Size({this.id, this.name});

  Size.fromJson(Map<dynamic, dynamic> json) {
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
