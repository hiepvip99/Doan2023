import 'package:dio/dio.dart';
import 'package:web_app/service/base_entity.dart';

import '../../model/network/product_manager_model.dart';
import '../netcommon/base_repository.dart';
import '../network.dart';

class ProductService {
  final String _allProductPath = 'api/product/shoeProducts';
  final String _allFavoriteProduct = 'api/favorite/favoriteProduct';
  final String _checkFavorite = 'api/favorite/favoriteProduct/isFavorited';
  final String _productById = 'api/product/shoeProductsById';
  final String _colorProduct = 'api/product/colorProduct';
  final String _sizeProduct = 'api/product/sizeProduct';
  final String _uploadImage = 'api/product/uploadImage';

  Future<ProductManagerModel?> getAllProduct(
      {int? currentPage,
      int? step,
      String? keyword,
      int? minPrice,
      int? maxPrice,
      int? manufacturerId,
      int? categoryId,
      int? colorId,
      String? gender,
      String? sortBy}) async {
    final queryParameter = <String, dynamic>{};
    if (step != null) {
      queryParameter['step'] = step;
    }
    if (currentPage != null) {
      queryParameter['page'] = currentPage;
    }
    if (keyword != null) {
      queryParameter['keyword'] = keyword;
    }
    if (minPrice != null) {
      queryParameter['minPrice'] = minPrice;
    }
    if (maxPrice != null) {
      queryParameter['maxPrice'] = maxPrice;
    }
    if (manufacturerId != null) {
      queryParameter['manufacturerId'] = manufacturerId;
    }
    if (categoryId != null) {
      queryParameter['categoryId'] = categoryId;
    }
    if (colorId != null) {
      queryParameter['color_id'] = colorId;
    }
    if (gender != null) {
      queryParameter['gender'] = gender;
    }
    if (sortBy != null) {
      queryParameter['sortBy'] = sortBy;
    }
    // queryParameter['step'] = step;
    // queryParameter['page'] = currentPage;
    // queryParameter['keyword'] = keyword;
    // queryParameter['minPrice'] = minPrice;
    // queryParameter['maxPrice'] = maxPrice;
    // queryParameter['manufacturerId'] = manufacturerId;
    // queryParameter['categoryId'] = categoryId;
    // queryParameter['color_id'] = colorId;
    // queryParameter['gender'] = gender;
    // queryParameter['sortBy'] = sortBy;
    final repo = BaseRepository(path: _allProductPath, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => ProductManagerModel.fromJson(e),
      queryParameters: queryParameter,
    );
    return response;
  }

  Future<ProductManagerModel?> getAllFavoriteProduct(
      {int? currentPage, int? step, String? accountId}) async {
    final queryParameter = <String, dynamic>{};
    if (step != null) {
      queryParameter['step'] = step;
    }
    if (currentPage != null) {
      queryParameter['page'] = currentPage;
    }
    if (accountId != null) {
      queryParameter['account_id'] = accountId;
    }
    final repo =
        BaseRepository(path: _allFavoriteProduct, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => ProductManagerModel.fromJson(e),
      queryParameters: queryParameter,
    );
    return response;
  }

  Future<BaseEntity?> addFavorite(Favorite favorite) async {
    final repo =
        BaseRepository(path: _allFavoriteProduct, method: HttpMethod.post);
    final response = await repo.queryByPath(
      (e) => ProductManagerModel.fromJson(e),
      data: favorite.toJson(),
    );
    return response;
  }

  Future<Favorite?> checkFavorite(Favorite favorite) async {
    // final queryParameters = <String, dynamic>{};
    // queryParameters['account_id']
    final repo = BaseRepository(path: _checkFavorite, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => Favorite.fromJson(e),
      queryParameters: favorite.toJson(),
    );
    return response;
  }

  Future<BaseEntity?> removeFavorite(List<Favorite> favorite) async {
    final listData = favorite.map((e) => e.toJson()).toList();
    final repo =
        BaseRepository(path: _allFavoriteProduct, method: HttpMethod.delete);
    final response = await repo.queryByPath(
      (e) => ProductManagerModel.fromJson(e),
      data: listData,
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

  Future<BaseEntity?> addColorProduct(ColorItemProduct colorModel) async {
    final repo = BaseRepository(path: _colorProduct, method: HttpMethod.post);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        data: colorModel.toJson());
    return response;
  }

  Future<BaseEntity?> updateColorProduct(ColorItemProduct colorModel) async {
    final repo = BaseRepository(path: _colorProduct, method: HttpMethod.put);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        data: colorModel.toJson());
    return response;
  }

  Future<BaseEntity?> deleteColorProduct(ColorItemProduct colorModel) async {
    final repo = BaseRepository(path: _colorProduct, method: HttpMethod.delete);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        data: colorModel.toJson());
    return response;
  }

  Future<BaseEntity?> addSizeProduct(SizeItemProduct sizeModel) async {
    final repo = BaseRepository(path: _sizeProduct, method: HttpMethod.post);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        data: sizeModel.toJson());
    return response;
  }

  Future<BaseEntity?> updateSizeProduct(SizeItemProduct sizeModel) async {
    final repo = BaseRepository(path: _sizeProduct, method: HttpMethod.put);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        data: sizeModel.toJson());
    return response;
  }

  Future<BaseEntity?> deleteSizeProduct(SizeItemProduct sizeModel) async {
    final repo = BaseRepository(path: _sizeProduct, method: HttpMethod.delete);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        data: sizeModel.toJson());
    return response;
  }

  Future<BaseEntity?> uploadImages(Images imageUpload) async {
    final repo = BaseRepository(path: _uploadImage, method: HttpMethod.put);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        data: FormData.fromMap(imageUpload.toUploadJson()));
    return response;
  }
}
