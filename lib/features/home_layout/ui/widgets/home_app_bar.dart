import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/export.dart';
import 'package:flutter_ecommerce_app/features/home_layout/ui/widgets/app_bar_actions_items.dart';
import 'package:flutter_ecommerce_app/features/profile/logic/profile_cubit.dart';
import 'package:flutter_ecommerce_app/features/profile/logic/profile_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.all(4),
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () => context.pushNamed(Routes.profileScreen),
            child: CircleAvatar(
              maxRadius: 22,
              backgroundColor: Colors.black54,
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                width: 40,
                height: 40,
                decoration: const ShapeDecoration(shape: CircleBorder()),
                child: BlocBuilder<ProfileCubit, ProfileState>(
                    buildWhen: (previous, current) =>
                        current != previous ||
                        current is GetLoginUserLoading ||
                        current is GetLoginUserSuccess ||
                        current is GetLoginUserError,
                    builder: (context, state) {
                      debugPrint('############ Rebuild ############');
                      if (state is GetLoginUserLoading) {
                        return const ShimmerPlaceHolder();
                      }
                      String? image = context.read<ProfileCubit>().userModel?.image;
                      if (state is GetLoginUserSuccess) {
                        image = state.userModel.image ?? '';
                      }
                      return CachedNetworkImage(
                        imageUrl: image ?? '',
                        fit: BoxFit.cover,


                      );
                    }),
              ),
            ),
          ),
        ),
        const Expanded(child: AppBarSearchField()),
        const FavoriteAndNotifactions()
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);
}
