import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? backButton;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.backButton,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: backButton == null
          ? IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.neutralGrey,
                size: 24,
              ),
            )
          : null,
      title: Text(
        title,
        style: AppStyles.headingH4,
      ),
      actions: actions,
      bottom: PreferredSize(
          preferredSize: preferredSize,
          child: const Divider(
            color: AppColors.neutralLight,
          )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 16);
}
