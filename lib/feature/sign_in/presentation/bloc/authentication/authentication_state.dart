import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState {}

class InitialAuthenticationState extends AuthenticationState {}

class SingInStart extends AuthenticationState {}

class CredentialSuccess extends AuthenticationState {
  CredentialSuccess({
    required this.token,
    required this.phoneNumber,
  });

  final String token;
  final String phoneNumber;
}

class AuthenticationFail extends AuthenticationState {
  final int? errorMessage;

  AuthenticationFail({this.errorMessage});
}

class SuccessLogOut extends AuthenticationState {}

class LoginSuccessState extends AuthenticationState {}

class SetUserDataState extends AuthenticationState {
  final bool hasUser;
  final String? uid;
  final String phoneNumber;

  SetUserDataState({
    required this.phoneNumber,
    this.hasUser = true,
    this.uid,
  });
}
