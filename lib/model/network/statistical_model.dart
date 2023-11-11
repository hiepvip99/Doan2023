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
