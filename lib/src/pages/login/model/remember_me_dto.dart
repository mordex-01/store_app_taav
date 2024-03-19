class RememberMeDto {
  RememberMeDto(this.isRememberMe);

  final bool? isRememberMe;

  Map<String, dynamic> toJson() => {"isRememberMe": isRememberMe ?? false};
}
