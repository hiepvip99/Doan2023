class User {
  String? userId;
  String? email;
  String? fullName;
  String? phoneNumber;
  String? address;
  String? accountId;

  User(
      {this.userId,
      this.email,
      this.fullName,
      this.phoneNumber,
      this.address,
      this.accountId});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    email = json['email'];
    fullName = json['full_name'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    accountId = json['account_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['email'] = email;
    data['full_name'] = fullName;
    data['phone_number'] = phoneNumber;
    data['address'] = address;
    data['account_id'] = accountId;
    return data;
  }
}
