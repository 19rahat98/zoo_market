import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zoo_market/common/theme/theme.dart';
import 'package:zoo_market/common/widgets/app_filled_color_button.dart';
import 'package:zoo_market/common/widgets/app_label_textfield.dart';
import 'package:zoo_market/feature/sign_in/presentation/bloc/signIn_with_phone_number/signIn_with_phone_number_bloc.dart';
import 'package:zoo_market/feature/sign_in/presentation/bloc/signIn_with_phone_number/signIn_with_phone_number_event.dart';
import 'package:zoo_market/feature/sign_in/presentation/bloc/signIn_with_phone_number/signIn_with_phone_number_state.dart';
import 'package:zoo_market/feature/sign_in/presentation/ui/enter_sms_code.dart';

class SignInWithPhoneNumber extends StatefulWidget {
  const SignInWithPhoneNumber({
    Key? key,
    this.onLoading,
    this.onError,
    required this.onSuccess,
    required this.textController,
    this.isEnable = true,
  }) : super(key: key);

  final bool isEnable;
  final VoidCallback? onError;
  final VoidCallback? onLoading;
  final MaskedTextController textController;
  final Function(SuccessPhoneSignInEntity) onSuccess;

  @override
  State<SignInWithPhoneNumber> createState() => _SignInWithPhoneNumberState();
}

class _SignInWithPhoneNumberState extends State<SignInWithPhoneNumber> {
  late SignInWithPhoneNumberBloc _bloc;

  @override
  void didChangeDependencies() {
    _bloc = context.read<SignInWithPhoneNumberBloc>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInWithPhoneNumberBloc, SignInWithPhoneNumberState>(
      listener: (context, state) {
        if (state is FirstStepStarted) {
          widget.onLoading?.call();
        } else if (state is SingInFirstStepSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EnterSignInSmsCode(
                bloc: _bloc,
                onSuccess: (value) {},
                phoneNumber: widget.textController.text,
              ),
            ),
          ).then((value) {
            if (value == null) {
              _bloc.add(LogOutFromPhoneVerificationEvent());
            }
          });
        } else if (state is SingInSecondStepSuccess) {
          widget.onSuccess.call(SuccessPhoneSignInEntity(
            state.credential,
            state.phoneNumber,
          ));
        } else if (state is LoggedOutFromPhoneVerificationState) {
          widget.onError?.call();
        }
      },
      child: Column(
        children: [
          const Text(
            'Введи номер телефона, чтобы авторизоваться.',
            style: AppTextStyle.body,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          AppLabelTextFieldWidget(
            contentPadding: const EdgeInsets.all(10),
            controller: widget.textController,
            hintTextValue: '+7 000 000 00 00',
          ),
          const SizedBox(
            height: 20,
          ),
          AppFilledColorButton(
            onTap: () {
              _bloc.add(
                SignInWithPhoneNumberFirstStep(
                  phoneNumber: widget.textController.text,
                ),
              );
            },
            height: 52,
            borderRadiusRadii: 30,
            color: AppColors.monoBrown,
            child: const Center(
              child: Text(
                'Войти',
                style: AppTextStyle.body,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Пользуясь нашим сервисом вы соглашаетесь с нашими  Правилами и Политикой конфиденциальности',
            style: AppTextStyle.regular,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class SuccessPhoneSignInEntity {
  final AuthCredential credential;
  final String phoneNUmber;

  SuccessPhoneSignInEntity(this.credential, this.phoneNUmber);
}
