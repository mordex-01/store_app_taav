import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:store_app_taav/src/infrastructure/utils/repository_utils.dart';
import 'package:http/http.dart' as http;
import 'package:store_app_taav/src/pages/seller/model/product_dto.dart';
import 'package:store_app_taav/src/pages/seller/model/product_view_model.dart';

class CartRepository {
  // Future<Either<String, List<CartViewModel>>> getCarts() async {
  //   var url = Uri.http(RepositoryUtils.baseUrl, RepositoryUtils.getCarts);
  //   final response = await http.get(url);
  //   if (response.statusCode >= 200 && response.statusCode < 400) {
  //     List<dynamic> carts = jsonDecode(response.body);
  //     List<CartViewModel> myCarts = [];
  //     for (var a in carts) {
  //       myCarts.add(CartViewModel.fromJson(a));
  //     }
  //     return Right(myCarts);
  //   } else {
  //     return Left("${response.statusCode}");
  //   }
  // }

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

  // Future<Either<String, String>> deleteCart({required String id}) async {
  //   var url =
  //       Uri.http(RepositoryUtils.baseUrl, RepositoryUtils.deleteCart(id: id));
  //   final response = await http.delete(url);
  //   if (response.statusCode >= 200 && response.statusCode < 400) {
  //     return const Right("sucsses");
  //   } else {
  //     return Left("${response.statusCode}");
  //   }
  // }
}
