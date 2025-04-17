import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/helpers/shared_pref_helper.dart';
import 'package:flutter_ecommerce_app/core/utils/app_constants.dart';
import 'package:flutter_ecommerce_app/core/utils/startup_methods.dart';
import 'package:flutter_ecommerce_app/features/auth/data/models/login_request.dart';
import 'package:flutter_ecommerce_app/features/auth/data/models/register_request.dart';
import 'package:flutter_ecommerce_app/features/auth/data/models/user_model.dart';
import 'package:flutter_ecommerce_app/features/auth/data/repository/auth_repository.dart';

import 'auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitialState());

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  void signUp() async {
    emit(RegisterLoadingState());
    final response = await authRepository.signUp(
      registerRequest: RegisterRequest(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          phone: phoneController.text),
    );
    response.when(
      success: (data) async {
        await saveLoginUser(data.userModel!);
        emit(RegisterSuccessState(message: data.message));
      },
      failure: (error) {
        emit(RegisterErrorState(message: error.toString()));
      },
    );
  }

  void signIn() async {
    emit(LoginLoadingState());
    final response = await authRepository.signIn(
      loginRequest: LoginRequest(
          email: emailController.text, password: passwordController.text),
    );
    response.when(
      success: (data) async {
        await saveLoginUser(data.userModel!);
        emit(LoginSuccessState(message: data.message));
      },
      failure: (error) => emit(LoginErrorState(message: error.message)),
    );
  }

  void logout() async {
    await SharedPref.removeSecuredData(SharedPrefKeys.userToken);
    await SharedPref.removeSecuredData(SharedPrefKeys.loginUser);
    await isUserLoggedIn();
  }

  Future saveLoginUser(UserModel userModel) async {
    await SharedPref.setSecuredString(
        SharedPrefKeys.loginUser, jsonEncode(userModel.toJson()));
    if (userModel.token != null) {
      await SharedPref.setSecuredString(SharedPrefKeys.userToken, userModel.token!);
      await isUserLoggedIn();
      await showOnBoarding();
      debugPrint('User Token Updated!');
    } else {
      debugPrint('User Token is Nullable!');
    }
  }
}
