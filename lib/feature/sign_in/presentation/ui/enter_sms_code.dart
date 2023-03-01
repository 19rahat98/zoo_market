import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:zoo_market/common/widgets/custom_spacer.dart';
import 'package:zoo_market/common/widgets/error_message_alert.dart';
import 'package:zoo_market/common/widgets/keybordDissmiser.dart';
import 'package:zoo_market/feature/sign_in/presentation/bloc/signIn_with_phone_number/signIn_with_phone_number_bloc.dart';
import 'package:zoo_market/feature/sign_in/presentation/bloc/signIn_with_phone_number/signIn_with_phone_number_event.dart';
import 'package:zoo_market/feature/sign_in/presentation/bloc/signIn_with_phone_number/signIn_with_phone_number_state.dart';

class EnterSignInSmsCode extends StatelessWidget {
  const EnterSignInSmsCode({
    Key? key,
    required this.bloc,
    required this.onSuccess,
    required this.phoneNumber,
  }) : super(key: key);

  final String phoneNumber;
  final SignInWithPhoneNumberBloc bloc;
  final Function(AuthCredential) onSuccess;

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissWidget(
      child: ColoredBox(
        color: Colors.white,
        child: Scaffold(
          body: BlocListener<SignInWithPhoneNumberBloc,
              SignInWithPhoneNumberState>(
            listener: (context, state) {
              if (state is SingInSecondStepSuccess) {
                onSuccess(state.credential);
                Navigator.pop(context, true);
              } else if (state is SignInWithPhoneNumberFailed) {
                if (state.errorMessage == '130296352') {
                  showErrorMessage(
                    context,
                    message: 'СМС код неверный',
                  );
                } else if (state.errorMessage == '505284406' ||
                    state.errorMessage == '185768934') {
                  showErrorMessage(
                    context,
                    message: 'Неверный логин или пароль',
                  );
                } else if (state.errorMessage == '34618382') {
                  showErrorMessage(
                    context,
                    message: 'Почта уже зрегрестрирована',
                  );
                } else {
                  showErrorMessage(
                    context,
                    message: 'СМС код неверный',
                  );
                }
              }
            },
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Color(0xff3DB7DE),
                          ),
                        ),
                        const Center(
                          child: Text(
                            'verification',
                          ),
                        ),
                        const ColumnSpacer(2.4),
                        const Center(
                          child: Text(
                            'enterSmsCode',
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 120,
                      ),
                      child: Column(
                        children: [
                          const ColumnSpacer(2.4),
                          PinPut(
                            fieldsCount: 6,
                            separator: const RowSpacer(2),
                            fieldsAlignment: MainAxisAlignment.spaceBetween,
                            eachFieldConstraints: const BoxConstraints(
                              minHeight: 40.0,
                              minWidth: 40.0,
                            ),
                            submittedFieldDecoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                width: 1,
                                color: const Color(0xffCDCDCD),
                              ),
                            ),
                            selectedFieldDecoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            followingFieldDecoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            onSubmit: (value) {
                              bloc.add(
                                SignInWithPhoneNumberSecondStep(
                                  code: value,
                                  phoneNumber: phoneNumber,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
