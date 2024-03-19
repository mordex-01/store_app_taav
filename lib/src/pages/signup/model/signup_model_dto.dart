class SignUpModelDto {
  SignUpModelDto({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.password,
    this.rememberMe,
  });

  final String firstName;
  final String lastName;
  final String userName;
  final String password;
  final bool? rememberMe;

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "userName": userName,
        "password": password,
      };
}
