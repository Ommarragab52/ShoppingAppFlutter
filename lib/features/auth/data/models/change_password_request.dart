class ChangePasswordRequest {
  final String currentPassword;
  final String newPassword;

  ChangePasswordRequest(this.currentPassword, this.newPassword);

  Map<String, dynamic> toJson() {
    return {
      'current_password': currentPassword,
      'new_password': newPassword,
    };
  }
}
