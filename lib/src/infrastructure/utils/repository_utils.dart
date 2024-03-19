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
}
