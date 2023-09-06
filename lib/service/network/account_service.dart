import '../../constant.dart';
import '../../model/network/account_model.dart';
import '../netcommon/base_repository.dart';
import '../network.dart';

class AccountService {
  final String _allAccountPath = 'api/account/getall';
  final String _accountById = 'api/account/get_by_id';
  Future<AccountsManagerModel?> getAllAccount(
      {int? currentPage, int? step, String? keyword}) async {
    final queryParameter = <String, dynamic>{};
    queryParameter['step'] = step;
    queryParameter['page'] = currentPage;
    queryParameter['keyword'] = keyword;
    final repo =
        BaseRepository(url: domain + _allAccountPath, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => AccountsManagerModel.fromJson(e),
      queryParameters: queryParameter,
    );
    return response;
  }

  Future<AccountsManagerModel?> getAccountById(int id) async {
    final repo =
        BaseRepository(url: domain + _accountById, method: HttpMethod.get);
    final queryParameter = <String, dynamic>{};
    queryParameter['accountId'] = id;
    final response = await repo.queryByPath(
        (e) => AccountsManagerModel.fromJson(e),
        queryParameters: queryParameter);
    return response;
  }
}
