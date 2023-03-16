part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String uId;

  LoginSuccessState(this.uId);
}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(this.error);
}

class AdminGetUserLoadingState extends LoginState {}

class AdminGetUserSuccessState extends LoginState {}

class AdminGetUserErrorState extends LoginState {
  final String error;

  AdminGetUserErrorState(this.error);
}
