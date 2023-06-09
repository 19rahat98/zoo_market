part of 'global_auth_cubit.dart';

@immutable
abstract class GlobalAuthState {}

class GlobalAuthInitial extends GlobalAuthState {}

class CompleteRegistrationState extends GlobalAuthState {
  final String? uid;
  final bool isCreatedOnDb;
  final String phoneNumber;

  CompleteRegistrationState(
    this.isCreatedOnDb,
    this.phoneNumber, {
    this.uid,
  });
}

class LogOutState extends GlobalAuthState {}

class SuccessAuthState extends GlobalAuthState {
  final UserDataEntity? userData;

  SuccessAuthState(this.userData);
}
