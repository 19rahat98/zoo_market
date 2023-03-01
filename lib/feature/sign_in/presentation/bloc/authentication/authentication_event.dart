import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';

@immutable
abstract class AuthenticationEvent {}

class LogOut extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final AuthCredential credential;

  LoggedIn({required this.credential});
}

class SignToken extends AuthenticationEvent {}
