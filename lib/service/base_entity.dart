// ignore_for_file: unnecessary_this

import '../extendsion/extendsion.dart';

class BaseEntity {
  BaseEntity({this.statusCode, this.message});

  BaseEntity.fromJson(map) {
    final entity = BaseEntity();
    entity.mapping(map);
    // return entity;
  }

  void mapping(map) {
    final statusCode = map['status'];
    if (statusCode is int) {
      this.statusCode = statusCode;
      this.message = asString(map['message']);
    } else if (statusCode is String && statusCode == 'OK') {
      this.statusCode = 200;
      this.message = null;
    }
  }

  bool isSuccess() {
    return statusCode == 200;
  }

  int? statusCode;
  String? message;
}
