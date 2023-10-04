import '../../model/network/order_manager_model.dart';
import '../base_entity.dart';
import '../netcommon/base_repository.dart';
import '../network.dart';

class OrderService {
  final String _orderUrl = 'api/order/shoeOrders';
  final String _statusOrderUrl = 'api/order/shoeOrders/status';
  final String _orderById = 'api/order/shoeOrderById';

  Future<OrderManagerModel?> getAllOrder(
      {int? currentPage, int? step, DateTime? date, String? accountId}) async {
    final queryParameter = <String, dynamic>{};
    queryParameter['step'] = step;
    queryParameter['page'] = currentPage;
    queryParameter['date'] = date;
    queryParameter['account_id'] = accountId;
    final repo = BaseRepository(path: _orderUrl, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => OrderManagerModel.fromJson(e),
      queryParameters: queryParameter,
    );
    return response;
  }

  Future<Order?> getOrderById(
      {int? currentPage, int? step, String? keyword}) async {
    final queryParameter = <String, dynamic>{};
    // queryParameter['step'] = step;
    // queryParameter['page'] = currentPage;
    // queryParameter['keyword'] = keyword;
    final repo = BaseRepository(path: _orderById, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => Order.fromJson(e['object']),
      queryParameters: queryParameter,
    );
    return response;
  }

  Future<BaseEntity?> addOrder(Order orderModel) async {
    final repo = BaseRepository(path: _orderUrl, method: HttpMethod.post);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        // queryParameters: queryParameter,
        data: orderModel.toJson());
    return response;
  }

  Future<BaseEntity?> updateOrder(Order orderModel) async {
    final repo = BaseRepository(path: _orderUrl, method: HttpMethod.put);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        // queryParameters: queryParameter,
        data: orderModel.toJson());
    return response;
  }

  Future<BaseEntity?> deleteOrder(Order orderModel) async {
    final repo = BaseRepository(path: _orderUrl, method: HttpMethod.delete);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        // queryParameters: queryParameter,
        data: orderModel.toJson());
    return response;
  }

  Future<BaseEntity?> changeStatus(Order orderModel) async {
    final repo = BaseRepository(path: _statusOrderUrl, method: HttpMethod.put);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        // queryParameters: queryParameter,
        data: orderModel.toJson());
    return response;
  }

  Future<OrderManagerModel?> getAllStatusOrder() async {
    final repo = BaseRepository(path: _statusOrderUrl, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => OrderManagerModel.fromJson(e),
    );
    return response;
  }
}
