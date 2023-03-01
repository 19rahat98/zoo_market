import 'package:flutter/material.dart';
import 'package:zoo_market/common/theme/theme.dart';
import 'package:zoo_market/common/widgets/app_icon_button.dart';
import 'package:zoo_market/common/widgets/app_text_button.dart';
import 'package:zoo_market/common/widgets/screen_wrapper.dart';

class UserDataUpdate extends StatefulWidget {
  const UserDataUpdate({Key? key}) : super(key: key);

  @override
  State<UserDataUpdate> createState() => _UserDataUpdateState();
}

class _UserDataUpdateState extends State<UserDataUpdate> {
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      top: false,
      backGround: AppColors.monoGray2,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              color: AppColors.mainOrange,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                AppIconButton(
                  AppIcons.icArrowLeft,
                  onPressed: () => Navigator.pop(context),
                  radius: 24,
                ),
                const SizedBox(
                  height: 24,
                ),
                const Center(
                  child: Text(
                    'Регистрация',
                    style: AppTextStyle.h2,
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppTextButton(
                        onTap: (){},
                        text: '1',
                        style: AppTextStyle.caption,
                      ),
                      AppTextButton(
                        onTap: (){},
                        text: '2',
                        style: AppTextStyle.caption,
                      ),
                      AppTextButton(
                        onTap: (){},
                        text: '3',
                        style: AppTextStyle.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          const Text(
            'Познакомимся?',
            style: AppTextStyle.title,
          ),
        ],
      ),
    );
  }
}
