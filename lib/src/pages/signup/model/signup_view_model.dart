class SignUpViewModel {
  SignUpViewModel({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.password,
  });

  final String firstName;
  final String lastName;
  final String userName;
  final String password;

  factory SignUpViewModel.fromJson(Map<String, dynamic> json) =>
      SignUpViewModel(
        firstName: json['firstName'],
        lastName: json['lastName'],
        userName: json['userName'],
        password: json['password'],
      );
}
