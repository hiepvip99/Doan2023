import 'package:dio/dio.dart';
import 'package:web_app/constant.dart';
import 'package:web_app/model/network/login_model.dart';
import 'package:web_app/service/network.dart';

import '../base_entity.dart';
import '../netcommon/base_repository.dart';

// import '../local/save_data.dart';

class LoginService {
  final String _path = 'shoe_store/login.php';
  Future<LoginModel?> loginApp(LoginModel data) async {
    final repo = BaseRepository(url: domain + _path, method: HttpMethod.post);
    final formData = FormData.fromMap(data.toJson());
    final response =
        await repo.queryByPath((e) => LoginModel.fromJson(e), data: formData);
    return response;
  }
}
