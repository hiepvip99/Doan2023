import '../../model/network/size_model.dart';
import '../base_entity.dart';
import '../netcommon/base_repository.dart';
import '../network.dart';

class SizeService {
  final String _sizeUrl = 'api/size/shoe-sizes';

  Future<SizeProductModel?> getAllSize(
      {int? currentPage, int? step, String? keyword}) async {
    final queryParameter = <String, dynamic>{};
    // queryParameter['step'] = step;
    // queryParameter['page'] = currentPage;
    // queryParameter['keyword'] = keyword;
    if (step != null) queryParameter['step'] = step;
    if (currentPage != null) queryParameter['page'] = currentPage;
    if (keyword != null) queryParameter['keyword'] = keyword;
    final repo = BaseRepository(path: _sizeUrl, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => SizeProductModel.fromJson(e),
      queryParameters: queryParameter,
    );
    return response;
  }

  Future<Size?> getSizeById(
      {int? currentPage, int? step, String? keyword}) async {
    final queryParameter = <String, dynamic>{};
    // queryParameter['step'] = step;
    // queryParameter['page'] = currentPage;
    // queryParameter['keyword'] = keyword;
    if (step != null) queryParameter['step'] = step;
    if (currentPage != null) queryParameter['page'] = currentPage;
    if (keyword != null) queryParameter['keyword'] = keyword;
    final repo = BaseRepository(path: _sizeUrl, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => Size.fromJson(e['object']),
      queryParameters: queryParameter,
    );
    return response;
  }

  Future<BaseEntity?> addSize(Size sizeModel) async {
    final repo = BaseRepository(path: _sizeUrl, method: HttpMethod.post);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        // queryParameters: queryParameter,
        data: sizeModel.toJson());
    return response;
  }

  Future<BaseEntity?> updateSize(Size sizeModel) async {
    final repo = BaseRepository(path: _sizeUrl, method: HttpMethod.put);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        // queryParameters: queryParameter,
        data: sizeModel.toJson());
    return response;
  }

  Future<BaseEntity?> deleteSize(Size sizeModel) async {
    final repo = BaseRepository(path: _sizeUrl, method: HttpMethod.delete);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        // queryParameters: queryParameter,
        data: sizeModel.toJson());
    return response;
  }
}
