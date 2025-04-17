class UpdateProfileRequest {
  final String? name;
  final String? email;
  final String? phone;
  final String? password;
  final String? imageBase64;

  UpdateProfileRequest(
    this.name,
    this.email,
    this.phone,
    this.password,
    this.imageBase64,
  );

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phone": phone,
      "email": email,
      "password": password,
      "image": imageBase64,
    };
  }
}
