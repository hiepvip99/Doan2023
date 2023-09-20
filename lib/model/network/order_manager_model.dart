// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../service/base_entity.dart';

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
    data['customerInfo'] = customerInfo;
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
  int? colorId;
  int? sizeId;
  int? quantity;

  Details(
      {this.id,
      this.orderId,
      this.product,
      this.colorId,
      this.sizeId,
      this.quantity});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    colorId = json['color_id'];
    sizeId = json['size_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['color_id'] = colorId;
    data['size_id'] = sizeId;
    data['quantity'] = quantity;
    return data;
  }
}

class Product {
  int? id;
  String? name;
  int? manufacturerId;
  int? categoryId;
  String? gender;

  Product(
      {this.id, this.name, this.manufacturerId, this.categoryId, this.gender});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    manufacturerId = json['manufacturer_id'];
    categoryId = json['category_id'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['manufacturer_id'] = manufacturerId;
    data['category_id'] = categoryId;
    data['gender'] = gender;
    return data;
  }
}

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

class Customer {
  int? id;
  String? name;
  String? phoneNumber;
  String? dateOfBirth;
  String? email;
  int? idAccount;
  String? image;

  Customer(
      {this.id,
      this.name,
      this.phoneNumber,
      this.dateOfBirth,
      this.email,
      this.idAccount,
      this.image});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    dateOfBirth = json['date_of_birth'];
    email = json['email'];
    idAccount = json['id_account'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['date_of_birth'] = dateOfBirth;
    data['email'] = email;
    data['id_account'] = idAccount;
    data['image'] = image;
    return data;
  }
}
