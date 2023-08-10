part of 'login_bloc.dart';

abstract class LoginEvent {}


class InitialLoginEvent extends LoginEvent{}
class SuccessLoginEvent extends LoginEvent{
  String userName;
  String password;
  SuccessLoginEvent(this.userName, this.password);
}

class LogoutEvent extends LoginEvent{}


