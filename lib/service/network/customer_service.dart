import 'package:dio/dio.dart';
import 'package:web_app/service/base_entity.dart';

import '../../model/network/customer_model.dart';
import '../../model/network/notification_model.dart';
import '../../model/network/product_manager_model.dart';
import '../netcommon/base_repository.dart';
import '../network.dart';

class CustomerService {
  final String _customer = 'api/customer/shoe_customers';
  final String _uploadImage = 'api/customer/shoe_customers/image';
  final String _notification = 'api/customer/shoe_notification';
  final String _customerAddress = 'api/customer/shoe_customers/address';
  final String _customerNotification =
      'api/customer/shoe_customers/notification';
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

  Future<Customer?> getCustomerById({String? accountId}) async {
    final queryParameter = <String, dynamic>{};
    queryParameter['accountId'] = accountId;
    final repo = BaseRepository(path: _customerById, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => Customer.fromJson(e),
      queryParameters: queryParameter,
    );
    return response;
  }

  Future<NotificationUser?> getNotification({String? accountId}) async {
    final queryParameter = <String, dynamic>{};
    queryParameter['accountId'] = accountId;
    final repo = BaseRepository(path: _notification, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => NotificationUser.fromJson(e),
      queryParameters: queryParameter,
    );
    return response;
  }

  Future<BaseEntity?> updateAddress(
      List<String> addresses, int customerId) async {
    final body = <String, dynamic>{};
    body['addresses'] = addresses;
    body['customerId'] = customerId;
    final repo = BaseRepository(path: _customerAddress, method: HttpMethod.put);
    final response = await repo.queryByPath(
      (e) => BaseEntity.fromJson(e),
      data: body,
    );
    return response;
  }

  Future<BaseEntity?> updateCustomerInfo(Customer data) async {
    final repo = BaseRepository(path: _customer, method: HttpMethod.put);
    final response = await repo.queryByPath(
      (e) => BaseEntity.fromJson(e),
      data: data.toJson(),
    );
    return response;
  }

  Future<BaseEntity?> updateNotificationToken(
      String? accountId, String token) async {
    final body = <String, dynamic>{};
    body['idAccount'] = accountId;
    body['newToken'] = token;
    final repo =
        BaseRepository(path: _customerNotification, method: HttpMethod.put);
    final response = await repo.queryByPath(
      (e) => BaseEntity.fromJson(e),
      data: body,
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

  Future<Images?> uploadImages(Images imageUpload) async {
    final repo = BaseRepository(path: _uploadImage, method: HttpMethod.put);
    final response = await repo.queryByPath((e) => Images.fromJson(e),
        data: FormData.fromMap(imageUpload.toUploadSingle()));
    return response;
  }
}
