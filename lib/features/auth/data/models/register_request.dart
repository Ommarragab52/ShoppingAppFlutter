class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String phone;

  RegisterRequest({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'name': name,
      'phone': phone
    };
  }
}
