import 'package:flutter_ecommerce_app/features/auth/data/models/user_model.dart';
import 'package:flutter_ecommerce_app/features/profile/data/models/profile_response.dart';

sealed class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserModel userModel;

  ProfileSuccess(this.userModel);
}

class ProfileError extends ProfileState {
  final String? errorMsg;

  ProfileError(this.errorMsg);
}

class GetLoginUserLoading extends ProfileState {}

class GetLoginUserSuccess extends ProfileState {
  final UserModel userModel;

  GetLoginUserSuccess(this.userModel);
}

class GetLoginUserError extends ProfileState {
  final String? errorMsg;

  GetLoginUserError(this.errorMsg);
}
class UpdateProfileLoading extends ProfileState {}
class UpdateProfileSuccess extends ProfileState {
  final ProfileResponse profileResponse;
  UpdateProfileSuccess(this.profileResponse);
}
class UpdateProfileError extends ProfileState {
  final String? errorMsg;
  UpdateProfileError(this.errorMsg);
}
