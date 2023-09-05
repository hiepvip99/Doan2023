import 'package:web_app/service/base_entity.dart';

class AccountsManagerModel extends BaseEntity {
  List<AccountInfo>? data;
  List<Decentralization>? decentralization;
  List<AccountStatus>? accountStatus;

  AccountsManagerModel({this.data, this.decentralization, this.accountStatus});

  AccountsManagerModel.fromJson(Map<dynamic, dynamic> json) {
    if (json['data'] != null) {
      data = <AccountInfo>[];
      json['data'].forEach((v) {
        data!.add(AccountInfo.fromJson(v));
      });
    }
    if (json['decentralization'] != null) {
      decentralization = <Decentralization>[];
      json['decentralization'].forEach((v) {
        decentralization!.add(Decentralization.fromJson(v));
      });
    }
    if (json['account_status'] != null) {
      accountStatus = <AccountStatus>[];
      json['account_status'].forEach((v) {
        accountStatus!.add(AccountStatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.decentralization != null) {
      data['decentralization'] =
          this.decentralization!.map((v) => v.toJson()).toList();
    }
    if (this.accountStatus != null) {
      data['account_status'] =
          this.accountStatus!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AccountInfo {
  int? id;
  String? username;
  String? password;
  int? decentralizationId;
  int? statusId;
  String? customerName;
  String? phoneNumber;
  String? dateOfBirth;
  String? email;

  AccountInfo(
      {this.id,
      this.username,
      this.password,
      this.decentralizationId,
      this.statusId,
      this.customerName,
      this.phoneNumber,
      this.dateOfBirth,
      this.email});

  AccountInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    decentralizationId = json['decentralization_id'];
    statusId = json['status_id'];
    customerName = json['customer_name'];
    phoneNumber = json['phone_number'];
    dateOfBirth = json['date_of_birth'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['decentralization_id'] = this.decentralizationId;
    data['status_id'] = this.statusId;
    data['customer_name'] = this.customerName;
    data['phone_number'] = this.phoneNumber;
    data['date_of_birth'] = this.dateOfBirth;
    data['email'] = this.email;
    return data;
  }
}

class Decentralization {
  int? id;
  String? name;

  Decentralization({this.id, this.name});

  Decentralization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class AccountStatus {
  int? id;
  String? name;

  AccountStatus({this.id, this.name});

  AccountStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
