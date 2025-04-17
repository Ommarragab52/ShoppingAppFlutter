
import 'package:flutter_ecommerce_app/features/auth/data/models/user_model.dart';

class ProfileResponse {
  bool? status;
  dynamic message;
  UserModel? userModel;

  ProfileResponse({
      this.status, 
      this.message, 
      this.userModel,});

  ProfileResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    userModel = json['data'] != null ? UserModel.fromJson(json['data']) : null;
  }

}

