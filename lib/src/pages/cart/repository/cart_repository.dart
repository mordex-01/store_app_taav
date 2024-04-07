import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:store_app_taav/src/infrastructure/utils/repository_utils.dart';
import 'package:http/http.dart' as http;
import 'package:store_app_taav/src/pages/details/model/add_to_cart_dto.dart';
import 'package:store_app_taav/src/shared/cart_view_model.dart';

class CartRepository {
  Future<Either<String, List<CartViewModel>>> getCarts() async {
    var url = Uri.http(RepositoryUtils.baseUrl, RepositoryUtils.getCarts);
    final response = await http.get(url);
    if (response.statusCode >= 200 && response.statusCode < 400) {
      List<dynamic> carts = jsonDecode(response.body);
      List<CartViewModel> myCarts = [];
      for (var a in carts) {
        myCarts.add(CartViewModel.fromJson(a));
      }
      return Right(myCarts);
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

  Future<Either<String, String>> deleteCart({required String id}) async {
    var url =
        Uri.http(RepositoryUtils.baseUrl, RepositoryUtils.deleteCart(id: id));
    final response = await http.delete(url);
    if (response.statusCode >= 200 && response.statusCode < 400) {
      return const Right("sucsses");
    } else {
      return Left("${response.statusCode}");
    }
  }
}
