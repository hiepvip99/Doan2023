import '../../service/base_entity.dart';

class Customer extends BaseEntity {
  int? id;
  String? name;
  String? phoneNumber;
  String? dateOfBirth;
  String? email;
  int? idAccount;
  String? image;

  Customer(
      {this.id,
      this.name,
      this.phoneNumber,
      this.dateOfBirth,
      this.email,
      this.idAccount,
      this.image});

  Customer.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    dateOfBirth = json['date_of_birth'];
    email = json['email'];
    idAccount = json['id_account'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['date_of_birth'] = dateOfBirth;
    data['email'] = email;
    data['id_account'] = idAccount;
    data['image'] = image;
    return data;
  }
}
