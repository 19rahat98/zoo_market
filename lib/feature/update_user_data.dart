import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoo_market/common/widgets/app_text_button.dart';
import 'package:zoo_market/feature/global_auth/presentation/cubit/global_auth_cubit.dart';

class UpdateUserData extends StatelessWidget {
  const UpdateUserData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: AppTextButton(
          onTap: () {
            context.read<GlobalAuthCubit>().logOut();
          },
          text: 'logOut',
        ),
      ),
    );
  }
}
