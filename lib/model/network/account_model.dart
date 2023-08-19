import 'package:web_app/service/base_entity.dart';

import 'user_model.dart';

class AccountModel extends BaseEntity {
  String? accountId;
  String? username;
  String? password;
  String? role;
  User? user;

  AccountModel(
      {this.accountId, this.username, this.password, this.role, this.user});

  AccountModel.fromJson(Map<dynamic, dynamic> json) {
    accountId = json['account_id'];
    username = json['username'];
    password = json['password'];
    role = json['role'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_id'] = accountId;
    data['username'] = username;
    data['password'] = password;
    data['role'] = role;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
