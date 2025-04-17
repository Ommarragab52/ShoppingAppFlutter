import 'package:flutter_ecommerce_app/features/auth/data/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  bool? status;
  String? message;
  @JsonKey(name: "data")
  UserModel? userModel;

  RegisterResponse({this.status, this.message, this.userModel});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return _$RegisterResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
