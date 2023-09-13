import 'package:web_app/model/network/category_model.dart';
import 'package:web_app/service/base_entity.dart';

import '../netcommon/base_repository.dart';
import '../network.dart';

class CategoryService {
  final _category = "api/category/categories";
  final _getCategoryById = "api/category/categoriesById";

  Future<CategoryManagerModel?> getAllCategory(
      {int? currentPage, int? step, String? keyword}) async {
    final queryParameter = <String, dynamic>{};
    queryParameter['step'] = step;
    queryParameter['page'] = currentPage;
    queryParameter['keyword'] = keyword;
    final repo = BaseRepository(path: _category, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => CategoryManagerModel.fromJson(e),
      queryParameters: queryParameter,
    );
    return response;
  }

  Future<CategoryManagerModel?> getCategoryById(
      {int? currentPage, int? step, String? keyword}) async {
    final queryParameter = <String, dynamic>{};
    queryParameter['step'] = step;
    queryParameter['page'] = currentPage;
    queryParameter['keyword'] = keyword;
    final repo = BaseRepository(path: _getCategoryById, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => CategoryManagerModel.fromJsonById(e),
      queryParameters: queryParameter,
    );
    return response;
  }

  Future<BaseEntity?> addCategory(
      CategoryManagerModel categoryManagerModel) async {
    final repo = BaseRepository(path: _category, method: HttpMethod.post);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        // queryParameters: queryParameter,
        data: categoryManagerModel.toJsonAddObj());
    return response;
  }

  Future<BaseEntity?> updateCategory(
      CategoryManagerModel categoryManagerModel) async {
    final repo = BaseRepository(path: _category, method: HttpMethod.put);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        // queryParameters: queryParameter,
        data: categoryManagerModel.toJsonAddObj());
    return response;
  }

  Future<BaseEntity?> deleteCategory(
      CategoryManagerModel categoryManagerModel) async {
    final repo = BaseRepository(path: _category, method: HttpMethod.delete);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        // queryParameters: queryParameter,
        data: categoryManagerModel.toJsonAddObj());
    return response;
  }
}
