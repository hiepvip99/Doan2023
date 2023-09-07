import 'package:dio/dio.dart';
import 'package:web_app/service/base_entity.dart';

import '../../constant.dart';
import '../../model/network/account_model.dart';
import '../netcommon/base_repository.dart';
import '../network.dart';

class AccountService {
  final String _allAccountPath = 'api/account/getall';
  final String _accountById = 'api/account/get_by_id';
  final String _addAccount = 'api/account/add';
  final String _updateAccount = 'api/account/update';
  final String _deleteAccount = 'api/account/delete';

  Future<AccountsManagerModel?> getAllAccount(
      {int? currentPage, int? step, String? keyword}) async {
    final queryParameter = <String, dynamic>{};
    queryParameter['step'] = step;
    queryParameter['page'] = currentPage;
    queryParameter['keyword'] = keyword;
    final repo =
        BaseRepository(path: _allAccountPath, method: HttpMethod.get);
    final response = await repo.queryByPath(
      (e) => AccountsManagerModel.fromJson(e),
      queryParameters: queryParameter,
    );
    return response;
  }

  Future<AccountsManagerModel?> getAccountById(int id) async {
    final repo =
        BaseRepository(path: _accountById, method: HttpMethod.get);
    final queryParameter = <String, dynamic>{};
    queryParameter['accountId'] = id;
    final response = await repo.queryByPath(
        (e) => AccountsManagerModel.fromJson(e),
        queryParameters: queryParameter);
    return response;
  }

  Future<BaseEntity?> addAccount(
      AccountsManagerModel accountsManagerModel) async {
    final repo = BaseRepository(path: _addAccount, method: HttpMethod.post);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        data: accountsManagerModel.toJsonEditAccount());
    return response;
  }

  Future<BaseEntity?> updateAccount(
      AccountsManagerModel accountsManagerModel) async {
    final repo = BaseRepository(path: _updateAccount, method: HttpMethod.put);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        data: accountsManagerModel.toJsonEditAccount());
    return response;
  }

  Future<BaseEntity?> deleteAccount(
      AccountsManagerModel accountsManagerModel) async {
    final repo =
        BaseRepository(path: _deleteAccount, method: HttpMethod.delete);
    final response = await repo.queryByPath((e) => BaseEntity.fromJson(e),
        data: accountsManagerModel.toJsonEditAccount());
    return response;
  }
}
