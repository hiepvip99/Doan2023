import '../../extendsion/extendsion.dart';
import '../../service/base_entity.dart';

class LoginModel extends BaseEntity {
  LoginModel({this.username, this.password});
  String? account_id;
  int? role;
  LoginModel.fromJson(Map<dynamic, dynamic> json) {
    // mapping(json);
    message = json['message'];
    // super.mapping(json);
    final data = json['data'];
    if (data != null) {
      role = data['decentralization_id'];
      account_id = data['id'].toString();
    }
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
