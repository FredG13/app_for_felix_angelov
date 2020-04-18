import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStart extends AuthenticationEvent {}

class AuthSuccess extends AuthenticationEvent {}

class LogOut extends AuthenticationEvent {}
