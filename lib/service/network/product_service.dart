import 'package:web_app/service/base_entity.dart';

import '../../model/network/product_manager_model.dart';
import '../netcommon/base_repository.dart';
import '../network.dart';

class ProductService {
  final String _allProductPath = 'api/product/shoeProducts';
  final String _productById = 'api/product/shoeProductsById';
  final String _colorProduct = 'api/product/colorProduct';
  final String _sizeProduct = 'api/product/sizeProduct';

  Future<ProductManagerModel?> getAllProduct(
      {int? currentPage, int? step, String? keyword}) async {
    final queryParameter = <String, dynamic>{};
    queryParameter['step'] = step;
    queryParameter['page'] = currentPage;
    queryParameter['keyword'] = keyword;
    final repo = BaseRepository(path: _allProductPath, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => ProductManagerModel.fromJson(e),
      queryParameters: queryParameter,
    );
    return response;
  }

  Future<ProductManagerModel?> getProductById(int id) async {
    final repo = BaseRepository(path: _productById, method: HttpMethod.get);
    final queryParameter = <String, dynamic>{};
    queryParameter['id'] = id;
    final response = await repo.queryByPath(
        (e) => ProductManagerModel.fromJson(e),
        queryParameters: queryParameter);
    return response;
  }

  Future<BaseEntity?> addProduct(
      ProductManagerModel productsManagerModel) async {
    final repo = BaseRepository(path: _allProductPath, method: HttpMethod.post);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        data: productsManagerModel.toJsonAddEditDelete());
    return response;
  }

  Future<BaseEntity?> updateProduct(
      ProductManagerModel productsManagerModel) async {
    final repo = BaseRepository(path: _allProductPath, method: HttpMethod.put);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        data: productsManagerModel.toJsonAddEditDelete());
    return response;
  }

  Future<BaseEntity?> deleteProduct(
      ProductManagerModel productsManagerModel) async {
    final repo =
        BaseRepository(path: _allProductPath, method: HttpMethod.delete);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        data: productsManagerModel.toJsonAddEditDelete());
    return response;
  }

  Future<BaseEntity?> addColorProduct(Colors colorModel) async {
    final repo = BaseRepository(path: _colorProduct, method: HttpMethod.post);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        data: colorModel.toJson());
    return response;
  }

  Future<BaseEntity?> updateColorProduct(Colors colorModel) async {
    final repo = BaseRepository(path: _colorProduct, method: HttpMethod.put);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        data: colorModel.toJson());
    return response;
  }

  Future<BaseEntity?> deleteColorProduct(Colors colorModel) async {
    final repo = BaseRepository(path: _colorProduct, method: HttpMethod.delete);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        data: colorModel.toJson());
    return response;
  }

  Future<BaseEntity?> addSizeProduct(Sizes sizeModel) async {
    final repo = BaseRepository(path: _sizeProduct, method: HttpMethod.post);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        data: sizeModel.toJson());
    return response;
  }

  Future<BaseEntity?> updateSizeProduct(Sizes sizeModel) async {
    final repo = BaseRepository(path: _sizeProduct, method: HttpMethod.put);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        data: sizeModel.toJson());
    return response;
  }

  Future<BaseEntity?> deleteSizeProduct(Sizes sizeModel) async {
    final repo = BaseRepository(path: _sizeProduct, method: HttpMethod.delete);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        data: sizeModel.toJson());
    return response;
  }
}
