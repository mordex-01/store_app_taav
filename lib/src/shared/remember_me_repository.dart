import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:store_app_taav/src/infrastructure/utils/repository_utils.dart';
import 'package:store_app_taav/src/pages/login/model/remember_me_dto.dart';
import 'package:store_app_taav/src/pages/login/model/remember_me_view_model.dart';

class RememberMeRepository {
  Future<Either<String, RememberMeViewModel>> patchRememberMe(
      {required String route,
      required String id,
      required RememberMeDto dto}) async {
    var url = Uri.http(RepositoryUtils.baseUrl,
        RepositoryUtils.patchRememberMe(route: route, id: id));
    final response = await http.patch(url,
        headers: RepositoryUtils.header, body: jsonEncode(dto.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 400) {
      return Right(RememberMeViewModel.fromJson(jsonDecode(response.body)));
    } else {
      return Left("${response.statusCode}");
    }
  }
}
