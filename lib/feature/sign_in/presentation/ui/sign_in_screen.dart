import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zoo_market/common/theme/theme.dart';
import 'package:zoo_market/common/widgets/app_text_button.dart';
import 'package:zoo_market/common/widgets/screen_wrapper.dart';
import 'package:zoo_market/feature/global_auth/presentation/cubit/global_auth_cubit.dart';
import 'package:zoo_market/feature/sign_in/presentation/bloc/authentication/blocs.dart';
import 'package:zoo_market/feature/sign_in/presentation/ui/sign_in_with_phone.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late AuthBloc _authBloc;

  final _phoneNumberController = MaskedTextController(mask: "+7 000 000 0000");

  @override
  void initState() {
    _authBloc = context.read<AuthBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      bottom: false,
      body:  BlocListener<AuthBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is CredentialSuccess) {
            _authBloc.add(SignToken());
          } else if (state is SetUserDataState) {
            context.read<GlobalAuthCubit>().setUpdateUserData(
              uid: state.uid,
              isCreatedOnDb: state.hasUser,
            );
          } else if (state is LoginSuccessState) {
            context.read<GlobalAuthCubit>().getUserData();
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Center(
                  child: SvgPicture.asset(
                    AppIcons.icLogoApp,
                  ),
                ),
                const SizedBox(
                  height: 90,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 32,
                  ),
                  child: Text(
                    'Накапливай бонусы и получай скидки',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.h1,
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppTextButton(
                        onTap: () {},
                        text: 'Рус',
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      AppTextButton(
                        onTap: () {},
                        text: 'Каз',
                        style: AppTextStyle.textMob.copyWith(
                          color: AppColors.monoGray,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: AppColors.mainOrange,
                    ),
                    child: SignInWithPhoneNumber(
                      onLoading: () {},
                      onSuccess: (value) =>
                          _authBloc.add(
                            LoggedIn(credential: value),
                          ),
                      onError: () => _authBloc.add(LogOut()),
                      textController: _phoneNumberController,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
