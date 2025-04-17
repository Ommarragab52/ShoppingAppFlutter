import 'package:json_annotation/json_annotation.dart';

import '../user_model.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  bool? status;
  String? message;
  @JsonKey(name: "data")
  UserModel? userModel;

  LoginResponse({this.status, this.message, this.userModel});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return _$LoginResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
