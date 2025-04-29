import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/export.dart';
import 'package:flutter_ecommerce_app/features/favorites/logic/favorites_cubit.dart';
import 'package:flutter_ecommerce_app/features/favorites/logic/favorites_state.dart';
import 'package:flutter_ecommerce_app/features/profile/logic/profile_cubit.dart';
import 'package:flutter_ecommerce_app/features/profile/logic/profile_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarSearchField extends StatelessWidget {
  const AppBarSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(vertical: 4.h, horizontal: 4.w),
      child: AppTextFormField(
        hintText: 'Search Products',
        readOnly: true,
        autofocus: false,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide:
              const BorderSide(color: AppColors.neutralLight, strokeAlign: 1),
        ),
        onTap: () => context.pushNamed(Routes.productsSearchScreen),
        prefixIconColor: AppColors.primaryBlue,
        prefixIcon: Icons.search,
      ),
    );
  }
}

class FavoriteAndNotifications extends StatelessWidget {
  const FavoriteAndNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocConsumer<FavoritesCubit, FavoritesState>(
          listenWhen: (previous, current) {
            return current is AddDeleteFavoriteLoadingState ||
                current is AddDeleteFavoriteSuccessState ||
                current is AddDeleteFavoriteFailureState;
          },
          listener: (context, state) {
            if (state is AddDeleteFavoriteSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(appSnackBar(
                  content: state.message, state: SnackBarState.success));
            } else if (state is AddDeleteFavoriteFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(appSnackBar(
                  content: state.error, state: SnackBarState.error));
            }
          },
          builder: (context, state) {
            int favoritesCount =
                ServiceLocator.favoritesCubit.favoritesList?.length ?? -1;
            return IconButton(
              onPressed: () {
                context.pushNamed(Routes.favoritesScreen);
              },
              icon: Badge(
                backgroundColor: AppColors.primaryRed,
                padding: const EdgeInsets.all(1),
                offset: const Offset(6, -6),
                label: Text(
                  '$favoritesCount',
                  style:
                      AppStyles.captionnormalbold.copyWith(color: Colors.white),
                ),
                isLabelVisible: favoritesCount > 0,
                child: const Icon(
                  Icons.favorite_outline,
                  size: 24,
                  color: AppColors.neutralGrey,
                ),
              ),
            );
          },
        ),
        IconButton(
          onPressed: () {
            context.pushNamed(Routes.notificationsScreen);
          },
          icon: const Badge(
            backgroundColor: AppColors.primaryRed,
            smallSize: 8,
            largeSize: 8,
            child: Icon(
              Icons.notifications_outlined,
              size: 24,
              color: AppColors.neutralGrey,
            ),
          ),
        )
      ],
    );
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 16.w),
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
                    current != previous || current is GetLoginUserSuccess,
                builder: (context, state) {
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
    );
  }
}
