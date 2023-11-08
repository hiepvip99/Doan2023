import 'package:web_app/service/base_entity.dart';

class Customer extends BaseEntity {
  int? id;
  String? name;
  String? phoneNumber;
  DateTime? dateOfBirth;
  String? email;
  int? idAccount;
  String? image;
  bool? hasUpdateInfomation;
  List<String>? address;

  Customer(
      {this.id,
      this.name,
      this.phoneNumber,
      this.dateOfBirth,
      this.email,
      this.idAccount,
      this.image,
      this.address});

  Customer.fromJsonCheck(Map<dynamic, dynamic> json) {
    hasUpdateInfomation = json['hasUpdateInfomation'];
  }
  
  Customer.fromJson(Map<dynamic, dynamic> json) {
    address = [];
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    dateOfBirth = DateTime.tryParse(json['date_of_birth']);
    email = json['email'];
    idAccount = json['id_account'];
    image = json['image'];
    // address = json['address'].cast<String>();
    final addressJson = json['address'];
    if (addressJson is List) {
      for (var element in addressJson) {
        address!.add(element);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['date_of_birth'] = dateOfBirth?.toIso8601String();
    data['email'] = email;
    data['id_account'] = idAccount;
    data['image'] = image;
    data['address'] = address;
    return data;
  }
}

// class ImageCustomer{
//   String? path
// }