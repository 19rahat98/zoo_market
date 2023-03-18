import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';

@immutable
abstract class AuthenticationEvent {}

class LogOut extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final AuthCredential credential;
  final String phoneNumber;

  LoggedIn({
    required this.credential,
    required this.phoneNumber,
  });
}

class SignToken extends AuthenticationEvent {
  final String phoneNumber;

  SignToken(this.phoneNumber);
}
