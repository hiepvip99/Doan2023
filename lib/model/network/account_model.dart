import 'package:web_app/service/base_entity.dart';

class AccountsManagerModel extends BaseEntity {
  List<AccountInfo>? accounts;
  List<Decentralization>? decentralization;
  List<AccountStatus>? accountStatus;
  int? totalPage;

  bool? success;
  bool? hasUpdatePassword;

  // Model add / update / delete;
  AccountInfo? accountEdit;

  AccountsManagerModel(
      {this.accounts,
      this.decentralization,
      this.accountStatus,
      this.accountEdit});

  AccountsManagerModel.fromJsonForgotPass(Map<dynamic, dynamic> json) {
    statusCode = json['status'];
    success = json['success'];
    hasUpdatePassword = json['hasUpdatePassword'];
  }

  AccountsManagerModel.fromJson(Map<dynamic, dynamic> json) {
    // // super.mapping(json);
    if (json['data'] != null) {
      accounts = <AccountInfo>[];
      json['data'].forEach((v) {
        accounts!.add(AccountInfo.fromJson(v));
      });
    }
    if (json['totalPages'] is int) {
      totalPage = json['totalPages'];
    } else if (json['totalPages'] is String) {
      totalPage = int.tryParse(json['totalPages']);
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
    final Map<String, dynamic> data = <String, dynamic>{};
    if (accounts != null) {
      data['data'] = this.accounts!.map((v) => v.toJson()).toList();
    }
    if (decentralization != null) {
      data['decentralization'] =
          decentralization!.map((v) => v.toJson()).toList();
    }
    if (accountStatus != null) {
      data['account_status'] = accountStatus!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toJsonEditAccount() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (accountEdit != null) {
      data['id'] = accountEdit?.id;
      data['username'] = accountEdit?.username;
      data['password'] = accountEdit?.password;
      data['decentralization_id'] = accountEdit?.decentralizationId;
      data['status_id'] = accountEdit?.statusId;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['password'] = password;
    data['decentralization_id'] = decentralizationId;
    data['status_id'] = statusId;
    data['customer_name'] = customerName;
    data['phone_number'] = phoneNumber;
    data['date_of_birth'] = dateOfBirth;
    data['email'] = email;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
