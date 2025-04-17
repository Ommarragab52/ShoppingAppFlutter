import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/features/auth/data/models/user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/export.dart';

class AvatarNameWidget extends StatelessWidget {
  final UserModel userModel;

  const AvatarNameWidget(
    this.userModel, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16.w,
      children: [
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: CachedNetworkImage(imageUrl: userModel.image ?? ''),
              ),
            );
          },
          borderRadius: BorderRadius.circular(100),
          child: CircleAvatar(
            maxRadius: 62,
            backgroundColor: Colors.grey,
            child: CircleAvatar(
              maxRadius: 60,
              backgroundColor: Colors.grey,
              backgroundImage: CachedNetworkImageProvider(
                userModel.image ?? '',
              ),
            ),
          ),
        ),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.h,
            children: [
              Text(
                userModel.name ?? 'null',
                style: AppStyles.headingH5,
              ),
              Text(
                '@${userModel.id}',
                style: AppStyles.bodyTextNormalRegular
                    .copyWith(color: AppColors.neutralGrey),
              ),
            ])
      ],
    );
  }
}
