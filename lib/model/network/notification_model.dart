import 'package:web_app/service/base_entity.dart';

class NotificationUser extends BaseEntity {
  int? status;
  List<NotificationModel>? data;

  NotificationUser({this.status, this.data});

  NotificationUser.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <NotificationModel>[];
      json['data'].forEach((v) {
        data!.add(NotificationModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationModel {
  int? id;
  int? accountId;
  String? title;
  String? content;
  String? timestamp;

  NotificationModel(
      {this.id, this.accountId, this.title, this.content, this.timestamp});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['account_id'];
    title = json['title'];
    content = json['content'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['account_id'] = accountId;
    data['title'] = title;
    data['content'] = content;
    data['timestamp'] = timestamp;
    return data;
  }
}
