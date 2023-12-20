import '../../model/network/statistical_model.dart';
import '../netcommon/base_repository.dart';
import '../network.dart';

class StatisticalService {
  final _statisticalByDay = "api/statistics/day";
  final _statisticalProduct = "api/statistics/product";
  final _statisticalByMonth = "api/statistics/month";

  Future<StatisticalModel?> getStatisticalByDay(
      {DateTime? fromDate, DateTime? toDate}) async {
    final queryParameter = <String, dynamic>{};
    queryParameter['fromday'] = fromDate?.toIso8601String();
    queryParameter['today'] = toDate?.toIso8601String();
    final repo =
        BaseRepository(path: _statisticalByDay, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => StatisticalModel.fromJsonByDay(e),
      queryParameters: queryParameter,
    );
    return response;
  }

  Future<StatisticalModel?> getStatisticalByMonth(
      {DateTime? fromDate, DateTime? toDate}) async {
    final queryParameter = <String, dynamic>{};
    queryParameter['fromMonth'] = fromDate?.toIso8601String();
    queryParameter['toMonth'] = toDate?.toIso8601String();
    final repo =
        BaseRepository(path: _statisticalByMonth, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => StatisticalModel.fromJsonByMonth(e),
      queryParameters: queryParameter,
    );
    return response;
  }
  Future<ProductStatistical?> getStatisticalProduct(
      {DateTime? fromDate, DateTime? toDate}) async {
    final queryParameter = <String, dynamic>{};
    queryParameter['fromDate'] = fromDate?.toIso8601String();
    queryParameter['toDate'] = toDate?.toIso8601String();
    final repo =
        BaseRepository(path: _statisticalProduct, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => ProductStatistical.fromJson(e),
      queryParameters: queryParameter,
    );
    return response;
  }
}
