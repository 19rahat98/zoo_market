import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';

@immutable
abstract class SignInWithPhoneNumberState {}

class SingInFirstStepSuccess extends SignInWithPhoneNumberState {
  final String verificationId;

  SingInFirstStepSuccess(this.verificationId);
}

class SingInSecondStepSuccess extends SignInWithPhoneNumberState {
  SingInSecondStepSuccess({
    required this.phoneNumber,
    required this.credential,
  });

  final String phoneNumber;
  final AuthCredential credential;

}

class FirstStepStarted extends SignInWithPhoneNumberState{}

class LoggedOutFromPhoneVerificationState extends SignInWithPhoneNumberState{}

class SignInWithPhoneNumberFailed extends SignInWithPhoneNumberState{
  final String? errorMessage;

  SignInWithPhoneNumberFailed({this.errorMessage});
}

class InitialSignInWithPhoneNumberState extends SignInWithPhoneNumberState{}

class PhoneCodeAutoRetrievalTimeoutState extends SignInWithPhoneNumberState {
  final String verificationId;

  PhoneCodeAutoRetrievalTimeoutState(this.verificationId);
}
