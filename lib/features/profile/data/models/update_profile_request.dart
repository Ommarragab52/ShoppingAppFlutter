class UpdateProfileRequest {
  final String? name;
  final String? email;
  final String? phone;
  final String? imageBase64;

  UpdateProfileRequest(
    this.name,
    this.email,
    this.phone,
    this.imageBase64,
  );

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phone": phone,
      "email": email,
      "image": imageBase64,
    };
  }
}
