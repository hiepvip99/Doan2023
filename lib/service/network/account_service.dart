import '../../constant.dart';
import '../../model/network/account_model.dart';
import '../netcommon/base_repository.dart';
import '../network.dart';

class AccountService {
  final String _path = 'shoe_store/account.php';
  Future<AccountModel?> getAllAccount() async {
    final repo = BaseRepository(url: domain + _path, method: HttpMethod.post);
    final response = await repo.queryByPath(
      (e) => AccountModel.fromJson(e),
    );
    return response;
  }

  Future<AccountModel?> getAccountById(int id) async {
    final repo = BaseRepository(url: domain + _path, method: HttpMethod.post);
    final queryParameter = <String, dynamic>{};
    queryParameter['account_id'] = id;
    final response = await repo.queryByPath((e) => AccountModel.fromJson(e),
        queryParameters: queryParameter);
    return response;
  }
}
