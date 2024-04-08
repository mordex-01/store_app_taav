import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:store_app_taav/src/infrastructure/utils/repository_utils.dart';
import 'package:store_app_taav/src/pages/addproduct/model/add_product_dto.dart';
import 'package:store_app_taav/src/pages/seller/model/product_view_model.dart';
import 'package:http/http.dart' as http;

class EditRepository {
  Future<Either<String, ProductViewModel>> editProduct(
      {required String id, required AddProductDto dto}) async {
    var url =
        Uri.http(RepositoryUtils.baseUrl, RepositoryUtils.editProduct(id: id));
    final response = await http.patch(url,
        headers: RepositoryUtils.header, body: jsonEncode(dto.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 400) {
      return Right(ProductViewModel.fromJson(jsonDecode(response.body)));
    } else {
      return Left("${response.statusCode}");
    }
  }
}
