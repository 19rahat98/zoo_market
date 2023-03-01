import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';

@immutable
abstract class SignInWithPhoneNumberEvent {}


class SignInWithPhoneNumberFirstStep extends SignInWithPhoneNumberEvent {
  final String phoneNumber;

  SignInWithPhoneNumberFirstStep({required this.phoneNumber});
}

class PhoneVerificationCompletedEvent extends SignInWithPhoneNumberEvent {
  final AuthCredential authCredential;

  PhoneVerificationCompletedEvent(this.authCredential);
}

class PhoneVerificationFailedEvent extends SignInWithPhoneNumberEvent {
  final FirebaseAuthException? authException;
  final String? errorMessage;

  PhoneVerificationFailedEvent({this.authException, this.errorMessage});
}

class PhoneCodeSentEvent extends SignInWithPhoneNumberEvent {
  final String verificationId;

  PhoneCodeSentEvent(this.verificationId);
}

class PhoneCodeAutoRetrievalTimeoutEvent extends SignInWithPhoneNumberEvent {
  final String verificationId;

  PhoneCodeAutoRetrievalTimeoutEvent(this.verificationId);
}


class SignInWithPhoneNumberSecondStep extends SignInWithPhoneNumberEvent {
  final String code;
  final String? phoneNumber;

  SignInWithPhoneNumberSecondStep({required this.code, this.phoneNumber});
}


class LogOutFromPhoneVerificationEvent extends SignInWithPhoneNumberEvent{}