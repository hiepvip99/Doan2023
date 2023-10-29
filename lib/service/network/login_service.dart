import 'package:dio/dio.dart';
import 'package:web_app/constant.dart';
import 'package:web_app/model/network/login_model.dart';
import 'package:web_app/service/network.dart';

import '../base_entity.dart';
import '../netcommon/base_repository.dart';

// import '../local/save_data.dart';

class LoginService {
  final String _login = 'api/account/login';
  final String _register = 'api/account/register';
  Future<LoginModel?> loginApp(LoginModel data) async {
    final repo = BaseRepository(path: _login, method: HttpMethod.post);
    // final formData = FormData.fromMap();
    final response =
        await repo.queryByPath((e) => LoginModel.fromJson(e),
        data: data.toJson());
    return response;
  }

  Future<RegisterModel?> register(RegisterModel data) async {
    final repo = BaseRepository(path: _register, method: HttpMethod.post);
    // final formData = FormData.fromMap();
    final response = await repo.queryByPath((e) => RegisterModel.fromJson(e),
        data: data.toJson());
    return response;
  }
}
