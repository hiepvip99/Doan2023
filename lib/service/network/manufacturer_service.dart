import 'package:web_app/model/network/manufacturer_model.dart';
import 'package:web_app/service/base_entity.dart';

import '../netcommon/base_repository.dart';
import '../network.dart';

class ManufacturerService {
  final _manufacturer = "api/manufacturer/shoeManufacturers";
  final _getManufacturerById = "api/manufacturer/get_by_id";

  Future<ManufacturerManagerModel?> getAllManufacturer(
      {int? currentPage, int? step, String? keyword}) async {
    final queryParameter = <String, dynamic>{};
    // queryParameter['step'] = step;
    // queryParameter['page'] = currentPage;
    // queryParameter['keyword'] = keyword;
    if (step != null) queryParameter['step'] = step;
    if (currentPage != null) queryParameter['page'] = currentPage;
    if (keyword != null) queryParameter['keyword'] = keyword;
    final repo = BaseRepository(path: _manufacturer, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => ManufacturerManagerModel.fromJson(e),
      queryParameters: queryParameter,
    );
    return response;
  }

  Future<ManufacturerManagerModel?> getManufacturerById(
      {int? currentPage, int? step, String? keyword}) async {
    final queryParameter = <String, dynamic>{};
    // queryParameter['step'] = step;
    // queryParameter['page'] = currentPage;
    // queryParameter['keyword'] = keyword;
    if (step != null) queryParameter['step'] = step;
    if (currentPage != null) queryParameter['page'] = currentPage;
    if (keyword != null) queryParameter['keyword'] = keyword;
    final repo =
        BaseRepository(path: _getManufacturerById, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => ManufacturerManagerModel.fromJsonById(e),
      queryParameters: queryParameter,
    );
    return response;
  }

  Future<BaseEntity?> addManufacturer(
      ManufacturerManagerModel manufacturerManagerModel) async {
    final repo = BaseRepository(path: _manufacturer, method: HttpMethod.post);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        // queryParameters: queryParameter,
        data: manufacturerManagerModel.toJsonAddObj());
    return response;
  }

  Future<BaseEntity?> updateManufacturer(
      ManufacturerManagerModel manufacturerManagerModel) async {
    final repo = BaseRepository(path: _manufacturer, method: HttpMethod.put);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        // queryParameters: queryParameter,
        data: manufacturerManagerModel.toJsonAddObj());
    return response;
  }

  Future<BaseEntity?> deleteManufacturer(
      ManufacturerManagerModel manufacturerManagerModel) async {
    final repo = BaseRepository(path: _manufacturer, method: HttpMethod.delete);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        // queryParameters: queryParameter,
        data: manufacturerManagerModel.toJsonAddObj());
    return response;
  }
}
