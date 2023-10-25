import '../../service/base_entity.dart';

class DiscountModel extends BaseEntity {
  List<Discount>? data;
  // int? status;

  bool? success;
  int? customerId;
  Discount? discountToApply;
  int? discount;

  DiscountModel({this.data, this.discountToApply, this.customerId});

  DiscountModel.fromJson(Map<dynamic, dynamic> json) {
    super.mapping(json);
    success = json['success'];
    discount = json['discount'];
    if (json['data'] != null) {
      data = <Discount>[];
      json['data'].forEach((v) {
        data!.add(Discount.fromJson(v));
      });
    }
    // status = json['status'];
  }

  Map<String, dynamic> toJsonApply() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_id'] = customerId;
    data['discount_code'] = discountToApply?.code;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Discount {
  String? code;
  int? discount;
  DateTime? expirationDate;

  Discount({this.code, this.discount, this.expirationDate});

  Discount.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    discount = json['discount'];
    expirationDate = DateTime.tryParse(json['expiration_date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['discount'] = discount;
    data['expiration_date'] = expirationDate?.toIso8601String();
    return data;
  }
}
