class RepositoryUtils {
  static const String baseUrl = "127.0.0.1:3000";
  static const Map<String, String> header = {
    'Content-Type': 'application/json'
  };
  static const String signUpCustomer = "/customer";
  static const String signUpSeller = "/seller";
  static const String getCustomers = "/customer";
  static const String getSellers = "/seller";
  static String patchRememberMe({required String route, required String id}) =>
      "$route/$id";
  static String patchIsActive({required String id}) => "/product/$id";
  static String getProductById({required String id}) => "/product/$id";
  static const String getProducts = "/product";
  static const String addProduct = "/product";
  static const String getProductsTags = "/product";
  static const String addToCart = '/cart';
  static const String getCarts = '/cart';

  static String decreeseProductCount({required String id}) => "/product/$id";
  static String patchProduct({required String id}) => "/product/$id";
  static String editProduct({required String id}) => "/product/$id";

  static const String addCart = '/cart';
  static String editCart({required String id}) => '/cart/$id';
  static String deleteCart({required String id}) => '/cart/$id';
  static const String getCart = '/cart';
}
