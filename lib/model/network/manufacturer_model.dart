import 'package:web_app/service/base_entity.dart';

class ManufacturerManagerModel extends BaseEntity {
  int? currentPage;
  int? step;
  int? totalPages;
  List<Manufacturer>? manufacturer;
  Manufacturer? manufacturerObj;

  ManufacturerManagerModel(
      {this.currentPage,
      this.step,
      this.totalPages,
      this.manufacturer,
      this.manufacturerObj});

  ManufacturerManagerModel.fromJson(Map<dynamic, dynamic> json) {
    // super.mapping(json);
    currentPage = json['currentPage'];
    step = json['step'];
    totalPages = json['totalPages'];
    if (json['data'] != null) {
      manufacturer = <Manufacturer>[];
      json['data'].forEach((v) {
        manufacturer!.add(Manufacturer.fromJson(v));
      });
    }
  }

  ManufacturerManagerModel.fromJsonById(Map<dynamic, dynamic> json) {
    // super.mapping(json);
    if (json['object'] != null) {
      manufacturerObj = Manufacturer.fromJson(json['object']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['step'] = step;
    data['totalPages'] = totalPages;
    if (manufacturer != null) {
      data['manufacturer'] = manufacturer!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toJsonAddObj() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (manufacturerObj != null) {
      data['id'] = manufacturerObj?.id;
      data['name'] = manufacturerObj?.name;
    }
    return data;
  }
}

class Manufacturer {
  int? id;
  String? name;

  Manufacturer({this.id, this.name});

  Manufacturer.fromJson(Map<String, dynamic> json) {
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
