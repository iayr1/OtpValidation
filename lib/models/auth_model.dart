class AuthenticationModel {
  final String phoneNumber;
  final String password;
  
  AuthenticationModel({required this.phoneNumber, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }
}
