abstract class AuthState {}

class AuthInitialState extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  String? message;

  LoginSuccessState({this.message});
}

class LoginErrorState extends AuthState {
  String? message;

  LoginErrorState({this.message});
}

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {
  String? message;

  RegisterSuccessState({this.message});
}
class RegisterErrorState extends AuthState {
  String? message;

  RegisterErrorState({this.message});
}


class ChangePasswordLoadingState extends AuthState {}

class ChangePasswordSuccessState extends AuthState {
  String? message;

  ChangePasswordSuccessState({this.message});
}
class ChangePasswordErrorState extends AuthState {
  String? message;

  ChangePasswordErrorState({this.message});
}
