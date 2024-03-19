class RememberMeViewModel {
  RememberMeViewModel({required this.isRememberMe});

  final bool isRememberMe;

  factory RememberMeViewModel.fromJson(Map<String, dynamic> json) =>
      RememberMeViewModel(isRememberMe: json['isRememberMe']);
}
