import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/export.dart';

class ProfileItemWidget extends StatelessWidget {
  final String title;
  final String value;
  final String icon;
  final VoidCallback? onClick;

  const ProfileItemWidget({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset(
        icon,
        width: 24.w,
        height: 24.h,
      ),
      title: Text(
        title,
        style: AppStyles.headingH6,
      ),
      trailing: Row(
        spacing: 16.w,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: AppStyles.bodyTextNormalRegular.copyWith(
              color: AppColors.neutralGrey
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.neutralGrey,
            size: 20,
          )
        ],
      ),
      onTap: onClick,
    );
  }
}
