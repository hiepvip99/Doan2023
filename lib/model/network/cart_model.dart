import 'package:web_app/service/base_entity.dart';

import 'order_manager_model.dart';

class CartManagerModel extends BaseEntity {
  int? status;
  List<ProductInCart>? data;

  CartManagerModel({this.status, this.data});

  CartManagerModel.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ProductInCart>[];
      json['data'].forEach((v) {
        data!.add(ProductInCart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductInCart {
  int? id;
  String? accountId;
  int? productId;
  int? colorId;
  int? sizeId;
  int? quantity;
  String? name;
  int? inventoryQuantity;
  int? price;
  List<Images>? images;

  ProductInCart(
      {this.id,
      this.accountId,
      this.productId,
      this.colorId,
      this.sizeId,
      this.quantity,
      this.name,
      this.inventoryQuantity,
      this.price,
      this.images});

  ProductInCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['account_id'].toString();
    productId = json['product_id'];
    colorId = json['color_id'];
    sizeId = json['size_id'];
    quantity = json['quantity'];
    name = json['name'];
    inventoryQuantity = json['inventory_quantity'];
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
    data['id'] = id;
    data['account_id'] = accountId;
    data['product_id'] = productId;
    data['color_id'] = colorId;
    data['size_id'] = sizeId;
    data['quantity'] = quantity;
    data['name'] = name;
    data['inventory_quantity'] = inventoryQuantity;
    data['price'] = price;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

