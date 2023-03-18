import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:zoo_market/common/services/core_common_constant.dart';
import 'package:zoo_market/common/theme/theme.dart';
import 'package:zoo_market/common/widgets/app_filled_color_button.dart';
import 'package:zoo_market/common/widgets/app_icon_button.dart';
import 'package:zoo_market/common/widgets/app_label_textfield.dart';
import 'package:zoo_market/common/widgets/app_loading_container.dart';
import 'package:zoo_market/common/widgets/app_snack_bar_widget.dart';
import 'package:zoo_market/common/widgets/outline_button_widget.dart';
import 'package:zoo_market/common/widgets/screen_wrapper.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:zoo_market/feature/global_auth/presentation/cubit/global_auth_cubit.dart';
import 'package:zoo_market/feature/user_data_update/cubit/update_user_data_cubit.dart';

class UpdateDataPage extends StatelessWidget {
  const UpdateDataPage({
    Key? key,
    this.isCreatedOnDb = true,
    this.phoneNumber = CoreConstant.empty,
  }) : super(key: key);

  final bool isCreatedOnDb;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UpdateUserDataCubit>(
      create: (context) => UpdateUserDataCubit()..enterPN(phoneNumber),
      child: UserDataUpdate(
        phoneNumber: phoneNumber,
        isCreatedOnDb: isCreatedOnDb,
      ),
    );
  }
}

class UserDataUpdate extends StatefulWidget {
  const UserDataUpdate({
    Key? key,
    this.isCreatedOnDb = true,
    this.phoneNumber = CoreConstant.empty,
  }) : super(key: key);

  final bool isCreatedOnDb;
  final String phoneNumber;

  @override
  State<UserDataUpdate> createState() => _UserDataUpdateState();
}

class _UserDataUpdateState extends State<UserDataUpdate> {
  late UpdateUserDataCubit _cubit;

  var birthDayMask = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  void didChangeDependencies() {
    _cubit = context.read<UpdateUserDataCubit>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      top: false,
      backGround: AppColors.monoGray2,
      body: BlocConsumer<UpdateUserDataCubit, UpdateUserDataState>(
        buildWhen: (prev, current) => current is CommonUpdateUserDataState,
        listener: (context, state) {
          if (state is SuccessUpdatedUserDataState) {
            context.read<GlobalAuthCubit>().getUserData();
          }
        },
        builder: (context, state) {
          if (state is CommonUpdateUserDataState) {
            return AppLoadingContainer(
              isLoading: state.isLoading,
              child: LayoutBuilder(builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: 20,
                                  ),
                                  color: AppColors.mainOrange,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppOutlineButtonWidget(
                                              isCircle: true,
                                              child: const Text(
                                                '1',
                                                style: AppTextStyle.caption,
                                              ),
                                            ),
                                            AppOutlineButtonWidget(
                                              onTap: () {
                                                if (!widget.isCreatedOnDb) {
                                                  final snackBar = errorSnackBar(
                                                      title: 'Ошибка');
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                }
                                              },
                                              isCircle: true,
                                              borderColor: Colors.transparent,
                                              child: const Text(
                                                '2',
                                                style: AppTextStyle.caption,
                                              ),
                                            ),
                                            AppOutlineButtonWidget(
                                              onTap: () {},
                                              isCircle: true,
                                              borderColor: Colors.transparent,
                                              child: const Text(
                                                '3',
                                                style: AppTextStyle.caption,
                                              ),
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
                                const SizedBox(
                                  height: 30,
                                ),
                                AppLabelTextFieldWidget(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  contentPadding: const EdgeInsets.all(8),
                                  labelWidget: Text(
                                    'Имя',
                                    style: AppTextStyle.textMob.copyWith(
                                      color: AppColors.monoGray,
                                    ),
                                  ),
                                  errorMessage: state.fnError,
                                  onValueChanged: _cubit.enterFN,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                AppLabelTextFieldWidget(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  contentPadding: const EdgeInsets.all(8),
                                  labelWidget: Text(
                                    'Фамилия',
                                    style: AppTextStyle.textMob.copyWith(
                                      color: AppColors.monoGray,
                                    ),
                                  ),
                                  errorMessage: state.lnError,
                                  onValueChanged: _cubit.enterLN,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                AppLabelTextFieldWidget(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  contentPadding: const EdgeInsets.all(8),
                                  labelWidget: Text(
                                    'Дата рождения',
                                    style: AppTextStyle.textMob.copyWith(
                                      color: AppColors.monoGray,
                                    ),
                                  ),
                                  onValueChanged: _cubit.enterBD,
                                  errorMessage: state.bdError,
                                  inputType: TextInputType.number,
                                  textInputFormatters: [
                                    birthDayMask,
                                  ],
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Женщина',
                                      style: AppTextStyle.textInput.copyWith(
                                        color: !state.isMale
                                            ? AppColors.black
                                            : AppColors.monoGray,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    FlutterSwitch(
                                      width: 58,
                                      height: 36,
                                      padding: 4,
                                      toggleSize: 26,
                                      value: state.isMale,
                                      activeColor: AppColors.mainOrange,
                                      inactiveColor: AppColors.mainOrange,
                                      borderRadius: 20,
                                      onToggle: _cubit.changeGander,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Мужчина',
                                      style: AppTextStyle.textInput.copyWith(
                                        color: state.isMale
                                            ? AppColors.black
                                            : AppColors.monoGray,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                          AppFilledColorButton(
                            onTap: () => _cubit.updateUserData(
                              isRegState: widget.isCreatedOnDb,
                            ),
                            height: 52,
                            borderRadiusRadii: 30,
                            color: AppColors.mainOrange,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: const Center(
                              child: Text(
                                'Войти',
                                style: AppTextStyle.body,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
