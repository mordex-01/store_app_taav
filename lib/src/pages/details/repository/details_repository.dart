import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:store_app_taav/src/infrastructure/utils/repository_utils.dart';
import 'package:http/http.dart' as http;
import 'package:store_app_taav/src/pages/details/model/add_to_cart_dto.dart';
import 'package:store_app_taav/src/shared/cart_view_model.dart';

class DetailsRepository {
  Future<Either<String, CartViewModel>> addToCart(
      {required AddToCartDto dto}) async {
    var url = Uri.http(RepositoryUtils.baseUrl, RepositoryUtils.addToCart);
    final response = await http.post(url,
        headers: RepositoryUtils.header, body: jsonEncode(dto.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 400) {
      return Right(CartViewModel.fromJson(jsonDecode(response.body)));
    } else {
      return Left("${response.statusCode}");
    }
  }

  Future<Either<String, CartViewModel>> patchCart(
      {required AddToCartDto dto, required String id}) async {
    var url =
        Uri.http(RepositoryUtils.baseUrl, RepositoryUtils.patchCart(id: id));
    final response = await http.patch(url, body: jsonEncode(dto.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 400) {
      return Right(CartViewModel.fromJson(jsonDecode(response.body)));
    } else {
      return Left("${response.statusCode}");
    }
  }
}
