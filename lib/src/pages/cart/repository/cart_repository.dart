import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:store_app_taav/src/infrastructure/utils/repository_utils.dart';
import 'package:http/http.dart' as http;
import 'package:store_app_taav/src/pages/cart/model/cart_dto.dart';
import 'package:store_app_taav/src/pages/cart/model/cart_model.dart';
import 'package:store_app_taav/src/pages/seller/model/product_dto.dart';
import 'package:store_app_taav/src/pages/seller/model/product_view_model.dart';

class CartRepository {
  //////////////////

  Future<Either<String, List<CartModel>>> getCart() async {
    var url = Uri.http(RepositoryUtils.baseUrl, RepositoryUtils.getCart);
    final response = await http.get(url);
    if (response.statusCode >= 200 && response.statusCode < 400) {
      List<dynamic> carts = jsonDecode(response.body);
      List<CartModel> myCarts = [];
      for (var a in carts) {
        myCarts.add(CartModel.fromJson(a));
      }
      return Right(myCarts);
    } else {
      return Left("${response.statusCode}");
    }
  }

  Future<Either<String, CartModel>> deleteCart({required String id}) async {
    var url = Uri.http(RepositoryUtils.deleteCart(id: id));
    final response = await http.delete(url);
    if (response.statusCode >= 200 && response.statusCode < 400) {
      return Right(CartModel.fromJson(jsonDecode(response.body)));
    } else {
      return Left("${response.statusCode}");
    }
  }

  Future<Either<String, CartModel>> editCart(
      {required String id, required CartDto dto}) async {
    var url =
        Uri.http(RepositoryUtils.baseUrl, RepositoryUtils.editCart(id: id));
    final response = await http.patch(url, body: jsonEncode(dto.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 400) {
      return Right(CartModel.fromJson(jsonDecode(response.body)));
    } else {
      return Left("${response.statusCode}");
    }
  }

  Future<Either<String, CartModel>> addCart({required CartDto dto}) async {
    var url = Uri.http(RepositoryUtils.baseUrl, RepositoryUtils.addCart);
    final response = await http.post(url, body: jsonEncode(dto.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 400) {
      return Right(CartModel.fromJson(jsonDecode(response.body)));
    } else {
      return Left("${response.statusCode}");
    }
  }

////////////////////
  Future<Either<String, ProductViewModel>> patchProduct(
      {required ProductDto dto, required String id}) async {
    var url =
        Uri.http(RepositoryUtils.baseUrl, RepositoryUtils.patchProduct(id: id));
    final response = await http.patch(url, body: jsonEncode(dto.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 400) {
      return Right(ProductViewModel.fromJson(jsonDecode(response.body)));
    } else {
      return Left("${response.statusCode}");
    }
  }
}
