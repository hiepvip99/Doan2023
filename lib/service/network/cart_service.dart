import 'package:web_app/service/base_entity.dart';

import '../../model/network/cart_model.dart';
import '../netcommon/base_repository.dart';
import '../network.dart';

class CartService {
  final _cart = "api/cart/shoeCarts";
  // final _getCartById = "api/cart/categoriesById";

  Future<CartManagerModel?> getCartById(String? accountId) async {
    final queryParameter = <String, dynamic>{};
    // queryParameter['step'] = step;
    // queryParameter['page'] = currentPage;
    queryParameter['account_id'] = accountId;
    final repo = BaseRepository(path: _cart, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => CartManagerModel.fromJson(e),
      queryParameters: queryParameter,
    );
    return response;
  }

  Future<BaseEntity?> addCart(ProductInCart cartManagerModel) async {
    final repo = BaseRepository(path: _cart, method: HttpMethod.post);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        // queryParameters: queryParameter,
        data: cartManagerModel.toJson());
    return response;
  }

  Future<BaseEntity?> updateCart(ProductInCart cartManagerModel) async {
    final repo = BaseRepository(path: _cart, method: HttpMethod.put);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        // queryParameters: queryParameter,
        data: cartManagerModel.toJson());
    return response;
  }

  Future<BaseEntity?> deleteCart(ProductInCart cartManagerModel) async {
    final repo = BaseRepository(path: _cart, method: HttpMethod.delete);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        // queryParameters: queryParameter,
        data: cartManagerModel.toJson());
    return response;
  }
}
