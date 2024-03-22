import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:store_app_taav/src/infrastructure/utils/repository_utils.dart';
import 'package:http/http.dart' as http;
import 'package:store_app_taav/src/pages/addproduct/model/add_product_dto.dart';
import 'package:store_app_taav/src/pages/seller/model/product_view_model.dart';

class AddProductRepository {
  Future<Either<String, ProductViewModel>> addProduct(
      {required AddProductDto dto}) async {
    var url = Uri.http(RepositoryUtils.baseUrl, RepositoryUtils.addProduct);
    final response = await http.post(
      url,
      body: jsonEncode(dto.toJson()),
      headers: RepositoryUtils.header,
    );
    if (response.statusCode >= 200 && response.statusCode < 400) {
      return Right(ProductViewModel.fromJson(jsonDecode(response.body)));
    } else {
      return Left("${response.statusCode}");
    }
  }
}
