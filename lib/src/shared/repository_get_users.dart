import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:store_app_taav/src/infrastructure/utils/repository_utils.dart';
import 'package:store_app_taav/src/pages/signup/model/signup_view_model.dart';

class RepositoryGetUsers {
  Future<Either<String, List<SignUpViewModel>>> getUsers(
      {required String routeUrl}) async {
    var url = Uri.http(RepositoryUtils.baseUrl, routeUrl);
    final response = await http.get(url);
    if (response.statusCode >= 200 && response.statusCode < 400) {
      final List<dynamic> usersList = jsonDecode(response.body);
      final List<SignUpViewModel> users = [];
      for (var a in usersList) {
        users.add(SignUpViewModel.fromJson(a));
      }
      return Right(users);
    } else {
      return const Left("Error");
    }
  }
}
