import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/export.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_app_bar.dart';
import 'package:flutter_ecommerce_app/features/profile/logic/profile_cubit.dart';
import 'package:flutter_ecommerce_app/features/profile/logic/profile_state.dart';
import 'package:flutter_ecommerce_app/features/profile/ui/widgets/avatar_name_widget.dart';
import 'package:flutter_ecommerce_app/features/profile/ui/widgets/profile_item_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Profile',
          actions: [
            PopupMenuButton(
              borderRadius: BorderRadius.circular(100),
              position: PopupMenuPosition.under,
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        size: 16.w,
                      ),
                      horizontalSpace(8),
                      const Text('Edit Profile'),
                    ],
                  ),
                  onTap: () {
                    // navigate to edit profile screen
                    context.pushNamed(Routes.editProfileScreen);
                  },
                ),
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<ProfileCubit, ProfileState>(
            buildWhen: (previous, current) =>
                current is GetLoginUserLoading ||
                current is GetLoginUserSuccess ||
                current is GetLoginUserError,
            builder: (context, state) {
              if (state is GetLoginUserLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is GetLoginUserSuccess) {
                return Padding(
                  padding: EdgeInsets.all(16.h),
                  child: Column(
                    children: [
                      AvatarNameWidget(state.userModel),
                      verticalSpace(32),
                      ProfileItemWidget(
                        title: 'Email',
                        value: profileCubit.userModel.email ?? "Null",
                        icon: Assets.svgEmail,
                        onClick: () {},
                      ),
                      ProfileItemWidget(
                        title: 'Phone Number',
                        value: profileCubit.userModel.phone ?? "Null",
                        icon: Assets.svgPhone,
                        onClick: () {},
                      ),
                      ProfileItemWidget(
                        title: 'Change Password',
                        value: "•••••••••••••",
                        icon: Assets.svgPassword,
                        onClick: () {},
                      ),
                      ProfileItemWidget(
                        title: 'Logout ',
                        value: "",
                        icon: Assets.svgLogout,
                        onClick: () {
                          ServiceLocator.authCubit.logout();
                          context.pushAndRemoveNamed(
                              Routes.loginScreen, (route) => false);
                        },
                      )
                    ],
                  ),
                );
              }
              if (state is GetLoginUserError) {
                return Center(child: Text(state.errorMsg.toString()));
              } else {
                return Container();
              }
            },
          ),
        ));
  }
}
