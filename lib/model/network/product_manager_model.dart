// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:web_app/service/base_entity.dart';

class ProductManagerModel extends BaseEntity {
  int? currentPage;
  int? step;
  int? totalPages;
  String? keyword;
  List<Product>? product;

  Product? item;

  ProductManagerModel(
      {this.currentPage,
      this.step,
      this.totalPages,
      this.keyword,
      this.product,
      this.item});

  ProductManagerModel.fromJson(Map<dynamic, dynamic> json) {
    // super.mapping(json);
    currentPage = json['currentPage'];
    step = json['step'];
    totalPages = json['totalPages'];
    keyword = json['keyword'];
    if (json['data'] != null) {
      product = <Product>[];
      json['data'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    } else {
      item = Product.fromJson(json);
    }
  }

  Map<String, dynamic> toJsonAddEditDelete() {
    /* name,
      manufacturer_id,
      category_id,
      gender,
      product_size,
      product_color, */
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = item?.id;
    data['name'] = item?.name;
    data['manufacturer_id'] = item?.manufacturerId;
    data['category_id'] = item?.categoryId;
    data['gender'] = item?.gender;
    data['description'] = item?.description;
    data['product_size'] = item?.sizes?.map((e) => e.toJson()).toList();
    data['product_color'] = item?.colors?.map((e) => e.toJson()).toList();

    // if (product != null) {
    //   data['product'] = product!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  int? manufacturerId;
  int? categoryId;
  String? gender;
  String? description;
  List<ColorItemProduct>? colors;
  List<SizeItemProduct>? sizes;

  Product(
      {this.id,
      this.name,
      this.manufacturerId,
      this.categoryId,
      this.gender,
      this.colors,
      this.sizes});

  Product.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    manufacturerId = json['manufacturer_id'];
    categoryId = json['category_id'];
    gender = json['gender'];
    description = json['description'];
    if (json['colors'] != null) {
      colors = <ColorItemProduct>[];
      json['colors'].forEach((v) {
        colors!.add(ColorItemProduct.fromJson(v));
      });
    }
    if (json['sizes'] != null) {
      sizes = <SizeItemProduct>[];
      json['sizes'].forEach((v) {
        sizes!.add(SizeItemProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['manufacturer_id'] = manufacturerId;
    data['category_id'] = categoryId;
    data['gender'] = gender;
    if (colors != null) {
      data['colors'] = colors!.map((v) => v.toJson()).toList();
    }
    if (sizes != null) {
      data['sizes'] = sizes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ColorItemProduct extends BaseEntity {
  int? productColorId;
  int? productId;
  int? colorId;
  int? price;
  List<Images>? images;

  ColorItemProduct(
      {this.productColorId,
      this.colorId,
      this.price,
      this.images,
      this.productId});

  ColorItemProduct.fromJson(Map<String, dynamic> json) {
    productColorId = json['product_color_id'];
    colorId = json['color_id'];
    price = json['price'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = productColorId;
    data['color_id'] = colorId;
    data['price'] = price;
    if (images != null) {
      data['images'] = images!.map((v) => v.toUrlString()).toList();
    }
    return data;
  }
}

class Images extends BaseEntity {
  String? url;
  ColorItemProduct? infoUpload;
  List<File>? listImageUpload;
  int? productIdUpload;
  int? customerId;

  Images(
      {this.url,
      this.infoUpload,
      this.listImageUpload,
      this.productIdUpload,
      this.customerId});

  Images.fromJson(Map<dynamic, dynamic> json) {
    // super.mapping(json);
    url = json['url'];
  }

  String? toUrlString() {
    return url;
  }

  Map<String, dynamic> toUploadJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['color_id'] = infoUpload?.colorId;
    data['product_id'] = productIdUpload;
    if (listImageUpload != null) {
      data['images'] = listImageUpload
          ?.map((e) => MultipartFile.fromFileSync(e.path))
          .toList();
    }
    return data;
  }

  Map<String, dynamic> toUploadSingle() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerId'] = customerId;
    if (listImageUpload != null) {
      data['image'] = MultipartFile.fromFileSync(listImageUpload!.first.path);
    }
    return data;
  }
}

class SizeItemProduct extends BaseEntity {
  int? productSizeId;
  int? sizeId;
  int? colorId;
  int? quantity;

  SizeItemProduct(
      {this.productSizeId, this.sizeId, this.colorId, this.quantity});

  SizeItemProduct.fromJson(Map<String, dynamic> json) {
    productSizeId = json['product_size_id'];
    sizeId = json['size_id'];
    colorId = json['color_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_size_id'] = productSizeId;
    data['size_id'] = sizeId;
    data['color_id'] = colorId;
    data['quantity'] = quantity;
    return data;
  }
}

class Favorite extends BaseEntity {
  int? id;
  int? productId;
  String? accountId;
  bool? isFavorite;

  Favorite({
    this.productId,
    this.accountId,
  });

  Favorite.fromJson(Map<dynamic, dynamic> json) {
    isFavorite = json['isFavorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['account_id'] = accountId;
    return data;
  }
}
