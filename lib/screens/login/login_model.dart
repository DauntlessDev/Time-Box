class LoginModel {
  LoginModel(
      {this.email = '',
      this.password = '',
      this.submitEnabled = false,
      this.isLoading = false});

  final String email;
  final String password;
  final bool submitEnabled;
  final bool isLoading;

  LoginModel copyWith({
    String email,
    String password,
    bool submitEnabled,
    bool isLoading,
  }) {
    return LoginModel(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      submitEnabled: submitEnabled ?? this.submitEnabled,
    );
  }
}
