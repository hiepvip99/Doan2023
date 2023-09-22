import 'package:web_app/service/base_entity.dart';

class StatisticalModel extends BaseEntity {
  List<RevenueByDay>? byDayList;
  List<RevenueByMonth>? byMonthList;

  StatisticalModel.fromJsonByDay(Map<dynamic, dynamic> json) {
    byDayList = [];
    if (json is List) {
      json.forEach((key, value) {
        byDayList!
            .add(RevenueByDay(day: DateTime.tryParse(key), revenue: value));
      });
    }
  }
  StatisticalModel.fromJsonByMonth(Map<dynamic, dynamic> json) {
    byMonthList = [];
    if (json is List) {
      json.forEach((key, value) {
        byMonthList!
            .add(RevenueByMonth(month: DateTime.tryParse(key), revenue: value));
      });
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
  DateTime? month;
  int? revenue;

  RevenueByMonth({this.month, this.revenue});

  RevenueByMonth.fromJson(Map<String, dynamic> json) {
    month = DateTime.tryParse(json['month']);
    revenue = json['revenue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    data['revenue'] = revenue;
    return data;
  }
}
