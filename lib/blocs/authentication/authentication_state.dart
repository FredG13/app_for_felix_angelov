import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationInit extends AuthenticationState {}

class AuthenticationOk extends AuthenticationState {}

