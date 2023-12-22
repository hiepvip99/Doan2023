// import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

bool? asBool(obj) {
  if (obj == null) {
    return null;
  } else if (obj is bool?) {
    return obj;
  }
  return null;
}

String? asString(obj) {
  if (obj == null) {
    return null;
  }
  if (obj is String?) {
    return obj;
  }
  return obj?.toString();
}

int? asInt(obj) {
  if (obj == null) {
    return null;
  }
  if (obj is int?) {
    return obj;
  } else if (obj is String) {
    return int.tryParse(obj);
  } else if (obj is num?) {
    return obj?.toInt();
  }
  return null;
}

double? asDouble(obj) {
  if (obj == null) {
    return null;
  }
  if (obj is double?) {
    return obj;
  } else if (obj is num?) {
    return obj?.toDouble();
  } else if (obj is String) {
    return double.tryParse(obj);
  }
  return null;
}

T? asObject<T>(obj, T Function(Map<dynamic, dynamic> e) convert) {
  if (obj == null) {
    return null;
  }
  if (obj is Map<dynamic, dynamic>) {
    return convert(obj);
  }
  return null;
}

List<T>? asList<T>(obj, T Function(dynamic e) convert) {
  if (obj == null) {
    return null;
  }
  final List<T> list = [];
  obj.forEach((element) {
    list.add(convert(element));
  });
  return list;
}

List<T>? asSimpleMapList<T>(
    obj, T Function(dynamic key, dynamic value) convert) {
  if (obj == null) {
    return null;
  }
  final List<T> list = [];
  obj.forEach((key, value) {
    list.add(convert(key, value));
  });
  return list;
}

List<T>? asMapList<T>(obj, T Function(Map<dynamic, dynamic> e) convert) {
  if (obj == null) {
    return null;
  }
  final List<T> list = [];
  obj.forEach((element) {
    if (element is Map<dynamic, dynamic>) {
      list.add(convert(element));
    }
  });
  return list;
}

String formatDate(DateTime? dateTime) {
  if (dateTime == null) {
    return '';
  }
  final formatter = DateFormat('dd/MM/yyyy');
  final formattedDate = formatter.format(dateTime);
  return formattedDate;
}

String formatDateTime(DateTime? dateTime) {
  if (dateTime == null) {
    return '';
  }
  final formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
  final formattedDate = formatter.format(dateTime);
  return formattedDate;
}

String formatDateTime7(DateTime? dateTime) {
  if (dateTime == null) {
    return '';
  }

  // Chuyển múi giờ về UTC+7 bằng cách thêm 7 giờ
  DateTime localDateTime = dateTime.add(Duration(hours: 7));

  // Định dạng thời gian
  String formattedDate =
      '${localDateTime.day}/${localDateTime.month}/${localDateTime.year} ${localDateTime.hour}:${localDateTime.minute}:${localDateTime.second}';

  return formattedDate;
}


// // Sử dụng hàm
// DateTime currentDateTime = DateTime.now();
// String formattedDateTime = formatDateTime(currentDateTime);
// print(formattedDateTime);

String formatMoney(int amount) {
  final formatter = NumberFormat("#,###", "vi_VN");
  return "${formatter.format(amount)} đ";
}
