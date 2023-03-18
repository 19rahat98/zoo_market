import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoo_market/common/services/core_common_constant.dart';
import 'package:zoo_market/feature/sign_in/presentation/bloc/signIn_with_phone_number/signIn_with_phone_number_event.dart';
import 'package:zoo_market/feature/sign_in/presentation/bloc/signIn_with_phone_number/signIn_with_phone_number_state.dart';

class SignInWithPhoneNumberBloc
    extends Bloc<SignInWithPhoneNumberEvent, SignInWithPhoneNumberState> {
  SignInWithPhoneNumberBloc() : super(InitialSignInWithPhoneNumberState());

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? _verificationId;
  String _phoneNumber = CoreConstant.empty;

  @override
  Stream<SignInWithPhoneNumberState> mapEventToState(event) async* {
    if (event is LogOutFromPhoneVerificationEvent) {
      await _firebaseAuth.signOut();
      yield LoggedOutFromPhoneVerificationState();
    }
    if (event is SignInWithPhoneNumberFirstStep) {
      _phoneNumber = event.phoneNumber;
      try {
        verificationCompleted(AuthCredential phoneAuthCredential) {
          add(PhoneVerificationCompletedEvent(phoneAuthCredential));
        }

        verificationFailed(FirebaseAuthException authException) {
          add(PhoneVerificationFailedEvent(authException: authException));
        }

        codeSent(String verificationId, [int? forceResendingToken]) async {
          add(PhoneCodeSentEvent(verificationId));
        }

        codeAutoRetrievalTimeout(String verificationId) {
          add(PhoneCodeAutoRetrievalTimeoutEvent(verificationId));
        }

        await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: event.phoneNumber,
          timeout: const Duration(seconds: 120),
          verificationCompleted: verificationCompleted,
          verificationFailed: (FirebaseAuthException authException) {
            verificationFailed(authException);
          },
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        );
      } catch (e) {
        yield (SignInWithPhoneNumberFailed(errorMessage: e.toString()));
      }
    }

    _signInWithCredential(AuthCredential credential) async* {
      yield SingInSecondStepSuccess(credential: credential, phoneNumber:_phoneNumber);
    }

    if (event is SignInWithPhoneNumberSecondStep) {
      if (_verificationId != null) {
        try {
          final AuthCredential credential = PhoneAuthProvider.credential(
            verificationId: _verificationId ?? '',
            smsCode: event.code,
          );
          await _firebaseAuth.signInWithCredential(credential);
          yield* _signInWithCredential(credential);
        } on FirebaseAuthException catch (e) {
          yield (SignInWithPhoneNumberFailed(errorMessage: e.code));
        } catch (e) {
          yield (SignInWithPhoneNumberFailed(errorMessage: e.toString()));
        }
      }
    }

    if (event is PhoneVerificationCompletedEvent) {
      yield* _signInWithCredential(event.authCredential);
    }

    if (event is PhoneVerificationFailedEvent) {
      if (event.authException != null) {
        yield SignInWithPhoneNumberFailed(
          errorMessage: event.authException?.message,
        );
      } else {
        yield SignInWithPhoneNumberFailed(
          errorMessage: event.errorMessage,
        );
      }
    }

    if (event is PhoneCodeSentEvent) {
      _verificationId = event.verificationId;
      yield SingInFirstStepSuccess(event.verificationId);
    }

    if (event is PhoneCodeAutoRetrievalTimeoutEvent) {
      yield PhoneCodeAutoRetrievalTimeoutState(event.verificationId);
    }
  }
}
