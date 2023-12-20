import 'package:web_app/service/base_entity.dart';

class StatisticalModel extends BaseEntity {
  List<RevenueByDay>? byDayList;
  List<RevenueByMonth>? byMonthList;
  int? totalRevenue;

  StatisticalModel.fromJsonByDay(Map<dynamic, dynamic> json) {
    byDayList = [];

    if (json['data'] is List?) {
      final data = json['data'] as List;
      byDayList = data.map((e) => RevenueByDay.fromJson(e)).toList();
    }
    final total = json['total_revenue'];
    if (total is int?) {
      totalRevenue = total;
    }
    byDayList;
  }
  StatisticalModel.fromJsonByMonth(Map<dynamic, dynamic> json) {
    byMonthList = [];
    if (json['data'] is List) {
      final data = json['data'] as List;
      byMonthList = data.map((e) => RevenueByMonth.fromJson(e)).toList();
    }
    final total = json['total_revenue'];
    if (total is int?) {
      totalRevenue = total;
    }
  }
}

class RevenueByDay {
  DateTime? day;
  int? revenue;

  RevenueByDay({this.day, this.revenue});

  RevenueByDay.fromJson(Map<String, dynamic> json) {
    day = DateTime.tryParse(json['day']);
    revenue = json['revenue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['revenue'] = revenue;
    return data;
  }
}

class RevenueByMonth {
  String? month;
  int? revenue;

  RevenueByMonth({this.month, this.revenue});

  RevenueByMonth.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    revenue = json['revenue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    data['revenue'] = revenue;
    return data;
  }
}

class ProductStatistical extends BaseEntity {
  List<ProductThongKe>? data;
  int? status;

  ProductStatistical({this.data, this.status});

  ProductStatistical.fromJson(Map<dynamic, dynamic> json) {
    if (json['data'] != null) {
      data = <ProductThongKe>[];
      json['data'].forEach((v) {
        data!.add(ProductThongKe.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class ProductThongKe {
  int? id;
  String? name;
  int? totalQuantity;

  ProductThongKe({this.id, this.name, this.totalQuantity});

  ProductThongKe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    totalQuantity = json['total_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['total_quantity'] = totalQuantity;
    return data;
  }
}
