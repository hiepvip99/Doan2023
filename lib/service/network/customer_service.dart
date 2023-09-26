import '../../model/network/customer_model.dart';
import '../../model/network/order_manager_model.dart';
import '../netcommon/base_repository.dart';
import '../network.dart';

class CustomerService {
  final String _customer = 'api/customer/shoe_customers';

  Future<Customer?> getAllColor(
      {int? currentPage, int? step, String? keyword}) async {
    final repo = BaseRepository(path: _customer, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => Customer.fromJson(e),
      // queryParameters: queryParameter,
    );
    return response;
  }
}
