import 'package:web_app/service/base_entity.dart';

import '../../model/network/customer_model.dart';
import '../netcommon/base_repository.dart';
import '../network.dart';

class CustomerService {
  final String _customer = 'api/customer/shoe_customers';
  final String _customerById = 'api/customer/shoe_customersById';

  Future<Customer?> getAllCustomer(
      {int? currentPage, int? step, String? keyword}) async {
    final queryParameter = <String, dynamic>{};
    queryParameter['step'] = step;
    queryParameter['page'] = currentPage;
    queryParameter['keyword'] = keyword;
    final repo = BaseRepository(path: _customer, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => Customer.fromJson(e),
      queryParameters: queryParameter,
    );
    return response;
  }

  Future<Customer?> getCustomerById({int? accountId}) async {
    final queryParameter = <String, dynamic>{};
    queryParameter['accountId'] = accountId;
    final repo = BaseRepository(path: _customerById, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => Customer.fromJson(e),
      queryParameters: queryParameter,
    );
    return response;
  }

  // Future<BaseEntity?> addCustomer(Customer customer) async {
  //   // final queryParameter = <String, dynamic>{};
  //   // queryParameter['accountId'] = accountId;
  //   final repo = BaseRepository(path: _customerById, method: HttpMethod.post);
  //   final response = await repo.queryByPath(
  //     (e) => Customer.fromJson(e),
  //     queryParameters: customer.toJson(),
  //   );
  //   return response;
  // }

  // Future<BaseEntity?> uploadImages(Images imageUpload) async {
  //   final repo = BaseRepository(path: _uploadImage, method: HttpMethod.put);
  //   final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
  //       data: FormData.fromMap(imageUpload.toUploadJson()));
  //   return response;
  // }

  // Future<BaseEntity?> deleteCustomer(Customer customer) async {
  //   // final queryParameter = <String, dynamic>{};
  //   // queryParameter['accountId'] = accountId;
  //   final repo = BaseRepository(path: _customerById, method: HttpMethod.delete);
  //   final response = await repo.queryByPath(
  //     (e) => Customer.fromJson(e),
  //     queryParameters: customer.toJson(),
  //   );
  //   return response;
  // }

}
