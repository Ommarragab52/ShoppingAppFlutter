import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/features/home_layout/ui/widgets/app_bar_actions_items.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: const [
        ProfileWidget(),
        Expanded(child: AppBarSearchField()),
        FavoriteAndNotifications()
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);
}
