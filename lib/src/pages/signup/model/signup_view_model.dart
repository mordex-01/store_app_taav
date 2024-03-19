class SignUpViewModel {
  SignUpViewModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.userName,
      required this.password,
      this.isRememberMe});
  final String id;
  final String firstName;
  final String lastName;
  final String userName;
  final String password;
  final bool? isRememberMe;

  factory SignUpViewModel.fromJson(Map<String, dynamic> json) =>
      SignUpViewModel(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        userName: json['userName'],
        password: json['password'],
        isRememberMe: json['isRememberMe'],
      );
}
