import '../../model/network/discount_model.dart';
import '../base_entity.dart';
import '../netcommon/base_repository.dart';
import '../network.dart';

class DiscountService {
  final String _discountUrl = 'api/discount/Discount';
  final String _applyDiscountUrl = 'api/discount/applyDiscount';

  Future<DiscountModel?> getAllDiscount(
      {int? currentPage, int? step, String? keyword}) async {
    final repo = BaseRepository(path: _discountUrl, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => DiscountModel.fromJson(e),
      // queryParameters: queryParameter,
    );
    return response;
  }

  Future<DiscountModel?> addDiscount(Discount discountModel) async {
    final repo = BaseRepository(path: _discountUrl, method: HttpMethod.post);
    final response = await repo.queryByPath((e) => DiscountModel.fromJson(e),
        // queryParameters: queryParameter,
        data: discountModel.toJson());
    return response;
  }

  Future<DiscountModel?> applyDiscount(DiscountModel discountModel) async {
    final repo =
        BaseRepository(path: _applyDiscountUrl, method: HttpMethod.post);
    final response = await repo.queryByPath((e) => DiscountModel.fromJson(e),
        // queryParameters: queryParameter,
        // showError: true,
        data: discountModel.toJsonApply());
    return response;
  }

  Future<DiscountModel?> updateDiscount(Discount discountModel) async {
    final repo = BaseRepository(path: _discountUrl, method: HttpMethod.put);
    final response = await repo.queryByPath((e) => DiscountModel.fromJson(e),
        // queryParameters: queryParameter,
        data: discountModel.toJson());
    return response;
  }

  Future<DiscountModel?> deleteDiscount(Discount discountModel) async {
    final repo = BaseRepository(path: _discountUrl, method: HttpMethod.delete);
    final response = await repo.queryByPath((e) => DiscountModel.fromJson(e),
        // queryParameters: queryParameter,
        data: discountModel.toJson());
    return response;
  }
}
