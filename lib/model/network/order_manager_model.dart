// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../service/base_entity.dart';
import 'color_model.dart';
import 'customer_model.dart';
import 'product_manager_model.dart';

class OrderManagerModel extends BaseEntity {
  int? currentPage;
  int? step;
  int? totalPages;
  List<Order>? order;

  List<StatusOrder>? statusObj;

  OrderManagerModel({
    this.currentPage,
    this.step,
    this.totalPages,
    this.order,
    this.statusObj,
  });

  OrderManagerModel.fromJson(Map<dynamic, dynamic> json) {
    currentPage = json['currentPage'];
    step = json['step'];
    totalPages = json['totalPages'];
    if (json['data'] != null) {
      order = <Order>[];
      json['data'].forEach((v) {
        order!.add(Order.fromJson(v));
      });
    }
    if (json['statusObj'] != null) {
      statusObj = <StatusOrder>[];
      json['statusObj'].forEach((v) {
        statusObj!.add(StatusOrder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['step'] = step;
    data['totalPages'] = totalPages;
    if (order != null) {
      data['order'] = order!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order extends BaseEntity {
  int? id;
  // int? accountId;
  Customer? customerInfo;
  DateTime? orderDate;
  int? totalPrice;
  int? statusId;
  int? totalQuantity;
  String? paymentMethods;
  String? deliveryAddress;
  List<Details>? details;

  Order(
      {this.id,
      this.customerInfo,
      this.orderDate,
      this.totalPrice,
      this.statusId,
      this.paymentMethods,
      this.totalQuantity,
      this.deliveryAddress,
      this.details});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['customerInfo'] != null) {
      customerInfo = Customer.fromJson(json['customerInfo']);
    }
    orderDate = DateTime.tryParse(json['order_date'] ?? '');
    totalPrice = json['total_price'];
    statusId = json['status_id'];
    paymentMethods = json['payment_methods'];
    totalQuantity = json['total_quantity'];
    deliveryAddress = json['delivery_address'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['account_id'] = customerInfo?.idAccount;
    // data['customerInfo'] = customerInfo;
    data['order_date'] = orderDate?.toIso8601String();
    data['total_price'] = totalPrice;
    data['status_id'] = statusId;
    data['payment_methods'] = paymentMethods;
    data['delivery_address'] = deliveryAddress;
    data['total_quantity'] = totalQuantity;
    if (details != null) {
      data['order_details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  int? id;
  int? orderId;
  Product? product;
  ColorItemProduct? color;
  int? sizeId;
  int? quantity;

  Details(
      {this.id,
      this.orderId,
      this.product,
      this.color,
      this.sizeId,
      this.quantity});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    color =
        json['color'] != null ? ColorItemProduct.fromJson(json['color']) : null;
    sizeId = json['size_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    // if (product != null) {
    //   data['product'] = product!.toJson();
    // }
    data['product_id'] = product?.id;
    data['color_id'] = color?.colorId;
    // if (color != null) {
    //   data['color'] = color!.toJson();
    // }
    data['size_id'] = sizeId;
    data['quantity'] = quantity;
    return data;
  }
}

// class Color {
//   int? colorId;
//   List<Images>? images;

//   Color({this.colorId, this.images});

//   Color.fromJson(Map<String, dynamic> json) {
//     colorId = json['color_id'];
//     if (json['images'] != null) {
//       images = <Images>[];
//       json['images'].forEach((v) {
//         images!.add(new Images.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['color_id'] = this.colorId;
//     if (this.images != null) {
//       data['images'] = this.images!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class Images {
  String? url;

  Images({this.url});

  Images.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    return data;
  }
}

// class Product {
//   int? id;
//   String? name;
//   int? manufacturerId;
//   int? categoryId;
//   String? gender;

//   Product(
//       {this.id, this.name, this.manufacturerId, this.categoryId, this.gender});

//   Product.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     manufacturerId = json['manufacturer_id'];
//     categoryId = json['category_id'];
//     gender = json['gender'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['manufacturer_id'] = manufacturerId;
//     data['category_id'] = categoryId;
//     data['gender'] = gender;
//     return data;
//   }
// }

class StatusOrder {
  int? id;
  String? name;

  StatusOrder({this.id, this.name});

  StatusOrder.fromJson(Map<String, dynamic> json) {
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

class Review extends BaseEntity {
  int? id;
  int? productId;
  int? customerId;
  int? orderDetailId;
  double? rating;
  String? reviewText;
  DateTime? createdAt;
  String? customerName;
  String? customerImage;
  bool? hasReview;

  Review(
      {this.id,
      this.productId,
      this.customerId,
      this.orderDetailId,
      this.rating,
      this.reviewText,
      this.createdAt,
      this.customerName,
      this.customerImage});
      
  Review.fromJsonCheck(Map<dynamic, dynamic> json) {
    hasReview = json['hasReview'];
  }


  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    customerId = json['customer_id'];
    orderDetailId = json['order_detail_id'];
    rating = double.tryParse(json['rating'].toString());
    reviewText = json['review_text'];
    createdAt = DateTime.tryParse(json['created_at']);
    customerName = json['customer_name'];
    customerImage = json['customer_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['product_id'] = this.productId;
    data['customer_id'] = this.customerId;
    data['order_detail_id'] = this.orderDetailId;
    data['rating'] = this.rating;
    data['review_text'] = this.reviewText;
    // data['created_at'] = this.createdAt;
    // data['customer_name'] = this.customerName;
    // data['customer_image'] = this.customerImage;
    return data;
  }
}


// class Review extends BaseEntity {
//   int? id;
//   int? productId;
//   int? customerId;
//   String? customerName;
//   int? orderDetailId;
//   double? rating;
//   String? reviewText;
//   DateTime? createAt;

//   bool? hasReview;
//   Review({
//     this.id,
//     this.productId,
//     this.customerName,
//     this.customerId,
//     this.orderDetailId,
//     this.rating,
//     this.reviewText,
//     this.createAt,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'product_id': productId,
//       'customer_id': customerId,
//       'order_detail_id': orderDetailId,
//       'rating': rating,
//       'review_text': reviewText,
//     };
//   }

//   Review.fromJsonCheck(Map<dynamic, dynamic> json) {
//     hasReview = json['hasReview'];
//   }

//   factory Review.fromJson(Map<String, dynamic> json) {
//     return Review(
//       id: json['id'],
//       productId: json['product_id'],
//       customerId: json['customer_id'],
//       orderDetailId: json['order_detail_id'],
//       rating: double.tryParse(json['rating'].toString()),
//       reviewText: json['review_text'],
//       createAt: DateTime.tryParse(json['created_at']),
//     );
//   }
// }
class ReviewsModel extends BaseEntity {
  List<Review>? reviews;
  RatingCounts? ratingCounts;
  double? averageRating;
  int? totalRating;
  int? currentPage;
  int? step;
  int? totalPages;

  ReviewsModel(
      {this.reviews,
      this.ratingCounts,
      this.averageRating,
      this.totalRating,
      this.currentPage,
      this.step,
      this.totalPages});

  ReviewsModel.fromJson(Map<dynamic, dynamic> json) {
    if (json['reviews'] != null) {
      reviews = <Review>[];
      json['reviews'].forEach((v) {
        reviews!.add(Review.fromJson(v));
      });
    }
    ratingCounts = json['rating_counts'] != null
        ? RatingCounts.fromJson(json['rating_counts'])
        : null;
    averageRating = double.tryParse(json['average_rating'].toString());
    totalRating = json['total_rating'];
    currentPage = json['currentPage'];
    step = json['step'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    if (ratingCounts != null) {
      data['rating_counts'] = ratingCounts!.toJson();
    }
    data['average_rating'] = averageRating;
    data['total_rating'] = totalRating;
    data['currentPage'] = currentPage;
    data['step'] = step;
    data['totalPages'] = totalPages;
    return data;
  }
}

// class Reviews {
//   int? id;
//   int? productId;
//   int? customerId;
//   int? orderDetailId;
//   int? rating;
//   String? reviewText;
//   String? createdAt;

//   Reviews(
//       {this.id,
//       this.productId,
//       this.customerId,
//       this.orderDetailId,
//       this.rating,
//       this.reviewText,
//       this.createdAt});

//   Reviews.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     productId = json['product_id'];
//     customerId = json['customer_id'];
//     orderDetailId = json['order_detail_id'];
//     rating = json['rating'];
//     reviewText = json['review_text'];
//     createdAt = json['created_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['product_id'] = this.productId;
//     data['customer_id'] = this.customerId;
//     data['order_detail_id'] = this.orderDetailId;
//     data['rating'] = this.rating;
//     data['review_text'] = this.reviewText;
//     data['created_at'] = this.createdAt;
//     return data;
//   }
// }

class RatingCounts {
  int? star1;
  int? star2;
  int? star3;
  int? star4;
  int? star5;

  RatingCounts({this.star1, this.star2, this.star3, this.star4, this.star5});

  RatingCounts.fromJson(Map<String, dynamic> json) {
    star1 = json['star1'];
    star2 = json['star2'];
    star3 = json['star3'];
    star4 = json['star4'];
    star5 = json['star5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['star1'] = star1;
    data['star2'] = star2;
    data['star3'] = star3;
    data['star4'] = star4;
    data['star5'] = star5;
    return data;
  }
}
