import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zoo_market/common/services/core_common_constant.dart';
import 'package:zoo_market/common/theme/theme.dart';

/// базовый виджет для работы текст филдом
class AppLabelTextFieldWidget extends StatefulWidget {
  const AppLabelTextFieldWidget({
    Key? key,
    this.color,
    this.label,
    this.value,
    this.autofillHints,
    this.onValueChanged,
    this.isEnabled,
    this.onShowTrailingWhen,
    this.trailingOnCompleted,
    this.onShowTrailing,
    this.trailing,
    this.isPassword,
    this.controller,
    this.inputType,
    this.focusNode,
    this.errorMessage,
    this.maxLength,
    this.textInputAction,
    this.margin,
    this.contentPadding,
    this.padding,
    this.borderRadius,
    this.fontSize,
    this.fontWeight,
    this.onTap,
    this.labelWidget,
    this.textInputFormatters,
    this.prefixIconPath,
    this.sufixIconPath,
    this.hintTextValue,
    this.onSubmitted,
    this.isTextCapitalizationUpperCase = true,
    this.autofocus = false,
    this.removeButton = false,
  }) : super(key: key);

  final bool autofocus;

  /// цвет контенера
  final Color? color;

  /// лайдел текстового поля
  final String? label;

  /// лайдел виджет текстового поля
  final Widget? labelWidget;

  /// значение текстового поля
  final String? value;

  /// слушатель при вводе значение в текстовое поле
  final ValueChanged<String>? onValueChanged;

  /// автивное/неактивное текстовое поле
  final bool? isEnabled;

  /// функция по условию
  final bool Function(String value)? onShowTrailingWhen;

  /// Вызывается, когда пользователь указывает,
  /// что он закончил редактировать текст в поле.
  final Function(String value)? onSubmitted;

  /// виджет справой стороны при условии [onShowTrailingWhen]
  final Widget? trailingOnCompleted;

  /// событие при показе [trailing]
  final Function()? onShowTrailing;

  /// виджет справой стороны
  final Widget? trailing;

  /// флаг для опередения пароля (ЕСЛИ УКАЗАН ДАННЫЙ ФЛАГ,
  /// ТО ДРУГИЕ ИКОНКИ С ЛЕВОЙ СТОРОНЫ НЕ БУДУТ ОТОБРАЖАТЬСЯ)
  final bool? isPassword;

  /// контроллер для ввода текста
  final TextEditingController? controller;

  /// указываем тип поля
  final TextInputType? inputType;

  final FocusNode? focusNode;

  /// сообщение об ошибке
  final String? errorMessage;

  /// максимальная длина символов
  final int? maxLength;

  /// показывает action на кравиатуре, работает во всмеми типами кроме int
  final TextInputAction? textInputAction;

  /// добавляет margin
  final EdgeInsetsGeometry? margin;

  /// добавляет паддинг для контента(label или text)
  final EdgeInsetsGeometry? contentPadding;

  /// добавляет паддинг в рамке
  final EdgeInsetsGeometry? padding;

  /// радиус округления
  final BorderRadius? borderRadius;

  /// размер шрифта, который пишет пользователь
  final double? fontSize;

  /// толщина шрифта, который пишет пользователь
  final FontWeight? fontWeight;

  /// событие нажатия по полю
  final Function()? onTap;

  /// форматтируем текст по запросу
  final List<TextInputFormatter>? textInputFormatters;

  /// путь для prefix иконки
  final String? prefixIconPath;

  /// путь для sufix иконки
  final String? sufixIconPath;

  /// указываем текст подсказки
  final String? hintTextValue;

  /// Настраивает, как клавиатура будет выбирать
  /// клавиатуру в верхнем или нижнем регистре.
  final bool isTextCapitalizationUpperCase;

  final Iterable<String>? autofillHints;

  final bool removeButton;

  @override
  State<AppLabelTextFieldWidget> createState() =>
      _AppLabelTextFieldWidgetState();
}

class _AppLabelTextFieldWidgetState extends State<AppLabelTextFieldWidget> {
  /// флаг указывающий на скрыть/паказать пароль
  var _isViewPassword = false;

  bool _isViewTrailing = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: (widget.errorMessage?.isEmpty ?? true)
                      ? widget.color ?? Colors.white
                      : Colors.white,
                  border: Border.all(
                    color: (widget.errorMessage?.isEmpty ?? true)
                        ? AppColors.monoGray5
                        : AppColors.error,
                  ),
                  borderRadius: widget.borderRadius ??
                      const BorderRadius.all(
                        Radius.circular(8),
                      ),
                ),
                child: TextField(
                  autofocus: widget.autofocus,
                  key: widget.key,
                  autofillHints: widget.autofillHints,
                  onTap: () => widget.onTap?.call(),
                  textInputAction: widget.textInputAction,
                  focusNode: widget.focusNode,
                  onChanged: _onValueChanged,
                  style: AppTextStyle.textInput,
                  textCapitalization: widget.isTextCapitalizationUpperCase
                      ? TextCapitalization.sentences
                      : TextCapitalization.none,
                  maxLength: widget.maxLength,
                  // ignore: avoid_bool_literals_in_conditional_expressions
                  obscureText:
                      widget.isPassword ?? false ? !_isViewPassword : false,
                  controller: widget.controller,
                  onSubmitted: widget.onSubmitted,
                  inputFormatters: widget.textInputFormatters,
                  decoration: InputDecoration(
                    label: widget.labelWidget,
                    isDense: true,
                    prefixIcon: widget.prefixIconPath?.isNotEmpty ?? false
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: SvgPicture.asset(
                              widget.prefixIconPath!,
                              color: AppColors.monoGray,
                            ),
                          )
                        : null,
                    suffixIcon: suffixIcon(),
                    suffixIconConstraints: const BoxConstraints(
                      maxWidth: 40,
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      maxWidth: 40,
                    ),
                    hintText: widget.hintTextValue,
                    hintStyle: AppTextStyle.textMob.copyWith(
                      color: AppColors.monoGray,
                    ),
                    labelText: widget.label,
                    border: InputBorder.none,
                    counterText: CoreConstant.empty,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    labelStyle: AppTextStyle.textInput,
                    contentPadding: widget.contentPadding ??
                        const EdgeInsets.only(bottom: 8, top: 4),
                  ),
                  keyboardType: widget.inputType ?? TextInputType.text,
                  enabled: widget.isEnabled,
                ),
              ),
              _getTrailingWidget()
            ],
          ),
          Visibility(
            visible: widget.errorMessage != null &&
                (widget.errorMessage?.isNotEmpty ?? false),
            child: Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Text(
                _getErrorMessage(),
                style: AppTextStyle.body.copyWith(
                  color: AppColors.error,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// выводит ошибку
  String _getErrorMessage() {
    final errorMessage = widget.errorMessage ?? CoreConstant.empty;
    return errorMessage;
  }

  /// при вводе значение в текстовое поле
  void _onValueChanged(String value) {
    final isPassword = widget.isPassword ?? false;
    final isShowTrailing = widget.onShowTrailingWhen?.call(value) ?? false;

    if (!isPassword) {
      if (isShowTrailing) {
        widget.onShowTrailing?.call();
        _isViewTrailing = true;
      } else {
        _isViewTrailing = false;
      }
      setState(() {});
    }

    final controller = widget.controller;
    final onValueChanged = widget.onValueChanged;

    onValueChanged?.call(
      controller?.value.text ?? value,
    );
  }

  Widget _getTrailingWidget() {
    final isPassword = widget.isPassword ?? false;

    if (isPassword) {
      return Padding(
        padding: const EdgeInsets.only(right: 22),
        child: InkWell(
          onTap: () {
            setState(() {
              _isViewPassword = !_isViewPassword;
            });
          },
          child: SvgPicture.asset(
            _isViewPassword
                ? AppIcons.icVisibilityOffPassword
                : AppIcons.icVisibilityPassword,
            color:
                _isViewPassword ? AppColors.mainOrange : AppColors.monoGray,
          ),
        ),
      );
    }

    if (_isViewTrailing) {
      return widget.trailingOnCompleted ?? const SizedBox();
    }
    return widget.trailing ?? const SizedBox();
  }

  Widget suffixIcon() {
    if (widget.removeButton &&
        (widget.controller?.text.isNotEmpty ?? false)) {
      return InkWell(
        onTap: (){
          widget.controller?.clear();
          widget.onValueChanged?.call(CoreConstant.empty);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          padding:  const EdgeInsets.symmetric(
            horizontal: 7,
          ),
          decoration: const BoxDecoration(
              color: AppColors.monoGray,
              shape: BoxShape.circle
          ),
          child: SvgPicture.asset(
            AppIcons.icClose,
            color: Colors.white,
          ),
        ),
      );
    } else if (widget.sufixIconPath?.isNotEmpty ?? false) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: SvgPicture.asset(
          widget.sufixIconPath!,
          color: AppColors.monoGray,
        ),
      );
    }
    return const SizedBox.shrink();
  }
}

class AppTextFieldIcon {
  AppTextFieldIcon({
    this.icon,
    this.height,
    this.width,
  });

  final String? icon;
  final double? width;
  final double? height;
}
