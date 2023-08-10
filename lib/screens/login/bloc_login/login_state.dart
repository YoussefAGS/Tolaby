part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class StateLoginSuccess extends LoginState {}
class StateLogoutSuccess extends LoginState {}
class StateLoginLoading extends LoginState {}
class StateLoginFaluir extends LoginState {}

