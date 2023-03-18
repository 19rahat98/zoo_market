import 'package:flutter/material.dart';
import 'package:zoo_market/common/theme/theme.dart';

class AppLoadingContainer extends StatelessWidget {
  const AppLoadingContainer({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  final bool isLoading;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: isLoading ? () async => false : null,
      child: Stack(
        children: [
          child,
          Visibility(
            visible: isLoading,
            child: ColoredBox(
              color: AppColors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
