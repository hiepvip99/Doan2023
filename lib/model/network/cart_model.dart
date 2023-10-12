import 'package:web_app/service/base_entity.dart';

import 'order_manager_model.dart';

class CartManagerModel extends BaseEntity {
  int? status;
  List<Data>? data;

  CartManagerModel({this.status, this.data});

  CartManagerModel.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data extends BaseEntity {
  int? id;
  int? accountId;
  int? productId;
  int? colorId;
  int? sizeId;
  int? quantity;
  int? price;
  List<Images>? images;

  Data(
      {this.id,
      this.accountId,
      this.productId,
      this.colorId,
      this.sizeId,
      this.quantity,
      this.price,
      this.images});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['account_id'];
    productId = json['product_id'];
    colorId = json['color_id'];
    sizeId = json['size_id'];
    quantity = json['quantity'];
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
    // data['price'] = price;
    // if (images != null) {
    //   data['images'] = images!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

// class Images {
//   String? url;

//   Images({this.url});

//   Images.fromJson(Map<String, dynamic> json) {
//     url = json['url'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['url'] = url;
//     return data;
//   }
// }
