import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:store_app_taav/src/infrastructure/utils/repository_utils.dart';
import 'package:store_app_taav/src/pages/seller/model/product_view_model.dart';

class GetProductsRepository {
  Future<Either<String, List<ProductViewModel>>> getProducts() async {
    var url = Uri.http(RepositoryUtils.baseUrl, RepositoryUtils.getProducts);
    final response = await http.get(url);
    if (response.statusCode >= 200 && response.statusCode < 400) {
      final List<dynamic> products = jsonDecode(response.body);
      final List<ProductViewModel> myproducts = [];
      for (var a in products) {
        myproducts.add(ProductViewModel.fromJson(a));
      }
      return Right(myproducts);
    } else {
      return Left("${response.statusCode}");
    }
  }

  Future<Either<String, ProductViewModel>> getProductById(String id) async {
    var url = Uri.http(
        RepositoryUtils.baseUrl, RepositoryUtils.getProductById(id: id));
    final response = await http.get(url);
    if (response.statusCode >= 200 && response.statusCode < 400) {
      return Right(ProductViewModel.fromJson(jsonDecode(response.body)));
    } else {
      return Left("${response.statusCode}");
    }
  }
}
