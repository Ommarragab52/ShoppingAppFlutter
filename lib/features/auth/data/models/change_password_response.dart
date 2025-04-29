import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password_response.g.dart';

@JsonSerializable()
class ChangePasswordResponse {
  bool? status;
  String? message;
  @JsonKey(name: 'data')
  ChangePasswordData? changePasswordData;

  ChangePasswordResponse(this.status, this.message, this.changePasswordData);

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return _$ChangePasswordResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChangePasswordResponseToJson(this);
}
@JsonSerializable()
class ChangePasswordData {
  String? email;

  ChangePasswordData(this.email);

  factory ChangePasswordData.fromJson(Map<String, dynamic> json) {
    return _$ChangePasswordDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChangePasswordDataToJson(this);
}
