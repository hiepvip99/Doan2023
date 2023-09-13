import '../../model/network/color_model.dart';
import '../base_entity.dart';
import '../netcommon/base_repository.dart';
import '../network.dart';

class ColorService {
  final String _colorUrl = 'api/color/shoe-colors';

  Future<ColorProductModel?> getAllColor(
      {int? currentPage, int? step, String? keyword}) async {
    final repo = BaseRepository(path: _colorUrl, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => ColorProductModel.fromJson(e),
      // queryParameters: queryParameter,
    );
    return response;
  }

  Future<Color?> getColorById(
      {int? currentPage, int? step, String? keyword}) async {
    final queryParameter = <String, dynamic>{};
    queryParameter['step'] = step;
    queryParameter['page'] = currentPage;
    queryParameter['keyword'] = keyword;
    final repo = BaseRepository(path: _colorUrl, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => Color.fromJson(e['object']),
      queryParameters: queryParameter,
    );
    return response;
  }

  Future<BaseEntity?> addColor(Color colorModel) async {
    final repo = BaseRepository(path: _colorUrl, method: HttpMethod.post);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        // queryParameters: queryParameter,
        data: colorModel.toJson());
    return response;
  }

  Future<BaseEntity?> updateColor(Color colorModel) async {
    final repo = BaseRepository(path: _colorUrl, method: HttpMethod.put);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        // queryParameters: queryParameter,
        data: colorModel.toJson());
    return response;
  }

  Future<BaseEntity?> deleteColor(Color colorModel) async {
    final repo = BaseRepository(path: _colorUrl, method: HttpMethod.delete);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        // queryParameters: queryParameter,
        data: colorModel.toJson());
    return response;
  }
}
