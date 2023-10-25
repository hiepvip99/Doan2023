// ignore_for_file: unnecessary_this

import '../extendsion/extendsion.dart';

class BaseEntity {
  BaseEntity({this.statusCode, this.message, this.validations});

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
    } else if (map is Map<String, dynamic>) {
      final List<ValidationEntity> validations = [];

      map.keys.forEach((key) {
        String msg = '';
        final errors = map[key];
        if (errors is List<dynamic>) {
          msg = errors.join('\n');
          final error = ValidationEntity(key: key, message: msg);
          validations.add(error);
        } else if (errors is String) {
          final error = ValidationEntity(key: key, message: errors);
          validations.add(error);
        } else if (errors is Map<String, dynamic>) {
          errors.forEach((key, value) {
            String _message = '';
            if (value is List<dynamic>) {
              value.forEach((element) {
                if (_message.isNotEmpty) {
                  _message += '\n';
                }
                _message += element.toString();
              });
            }
            validations.add(ValidationEntity(key: key, message: _message));
          });
        }
      });
      this.validations = validations;
    }
  }

  bool isSuccess() {
    return statusCode == 200;
  }

  int? statusCode;
  String? message;
  List<ValidationEntity>? validations;
}

class ValidationEntity {
  ValidationEntity({required this.key, required this.message});

  String key;
  String message;
}
