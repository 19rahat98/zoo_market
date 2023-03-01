import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zoo_market/common/theme/theme.dart';
import 'package:zoo_market/feature/global_auth/presentation/cubit/global_auth_cubit.dart';
import 'package:zoo_market/feature/sign_in/presentation/ui/sign_in_screen.dart';
import 'package:zoo_market/feature/success_page.dart';
import 'package:zoo_market/feature/update_user_data.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalAuthCubit, GlobalAuthState>(
      builder: (context, state) {
        if (state is SuccessAuthState) {
          return const SuccessPage();
        }
        else if (state is GlobalAuthInitial) {
          return Scaffold(
            backgroundColor: AppColors.mainOrange,
            body: Center(
              child: SvgPicture.asset(
                AppIcons.icLogoSplash,
              ),
            ),
          );
        }
        else if (state is CompleteRegistrationState) {
          return const UpdateUserData();
        }
        return const SignInScreen();
      },
    );
  }
}
