import '../../extendsion/extendsion.dart';
import '../../service/base_entity.dart';

class LoginModel extends BaseEntity {
  LoginModel({this.username, this.password});
  String? userId;
  int? role;
  LoginModel.fromJson(Map<dynamic, dynamic> json) {
    // super.mapping(json);
    userId = asString(json['account_id']);
    role = asInt(json['role']);
  }
  String? username;
  String? password;
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
