import 'package:web_app/service/base_entity.dart';

class CategoryManagerModel extends BaseEntity {
  int? currentPage;
  int? step;
  int? totalPages;
  List<Category>? category;
  Category? categoryObj;

  CategoryManagerModel(
      {this.currentPage,
      this.step,
      this.totalPages,
      this.category,
      this.categoryObj});

  CategoryManagerModel.fromJson(Map<dynamic, dynamic> json) {
    super.mapping(json);
    currentPage = json['currentPage'];
    step = json['step'];
    totalPages = json['totalPages'];
    if (json['data'] != null) {
      category = <Category>[];
      json['data'].forEach((v) {
        category!.add(Category.fromJson(v));
      });
    }
  }

  CategoryManagerModel.fromJsonById(Map<dynamic, dynamic> json) {
    super.mapping(json);
    if (json['object'] != null) {
      categoryObj = Category.fromJson(json['object']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['step'] = step;
    data['totalPages'] = totalPages;
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toJsonAddObj() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categoryObj != null) {
      data['id'] = categoryObj?.id;
      data['name'] = categoryObj?.name;
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
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
