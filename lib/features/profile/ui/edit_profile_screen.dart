import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/export.dart';
import 'package:flutter_ecommerce_app/core/utils/app_regex.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_app_bar.dart';
import 'package:flutter_ecommerce_app/features/profile/logic/profile_cubit.dart';
import 'package:flutter_ecommerce_app/features/profile/logic/profile_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late ProfileCubit profileCubit;

  late GlobalKey<FormState> formKey;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    profileCubit = context.read<ProfileCubit>();
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Edit Profile'),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12.h,
                  children: [
                    Center(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          showModalBottomSheet(
                            showDragHandle: true,
                            useSafeArea: true,
                            constraints: BoxConstraints.loose(
                                const Size.fromHeight(200)),
                            context: context,
                            builder: (context) => SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Upload Image',
                                      style: AppStyles.bodyTextLargeRegular
                                          .copyWith(
                                              color: AppColors.neutralDark),
                                    ),
                                    verticalSpace(12),
                                    InkWell(
                                      onTap: () {
                                        profileCubit.uploadNewImage(
                                          fromGallery: false,
                                        );
                                        context.pop();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Row(
                                          spacing: 8.w,
                                          children: [
                                            const Icon(
                                              Icons.camera_alt,
                                              color: AppColors.neutralDark,
                                            ),
                                            Text('Camera',
                                                style: AppStyles
                                                    .bodyTextMediumRegular
                                                    .copyWith(
                                                        color: AppColors
                                                            .neutralDark)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        profileCubit.uploadNewImage(
                                          fromGallery: true,
                                        );
                                        context.pop();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Row(
                                          spacing: 8.w,
                                          children: [
                                            const Icon(
                                              Icons.photo_library_rounded,
                                              color: AppColors.neutralDark,
                                            ),
                                            Text('Gallery',
                                                style: AppStyles
                                                    .bodyTextMediumRegular
                                                    .copyWith(
                                                        color: AppColors
                                                            .neutralDark)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            CircleAvatar(
                              maxRadius: 102,
                              backgroundColor: Colors.black54,
                              child: Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                height: 200,
                                width: 200,
                                decoration: ShapeDecoration(
                                  shape: const CircleBorder(),
                                  color: Colors.grey[300],
                                ),
                                child: BlocBuilder<ProfileCubit, ProfileState>(
                                    buildWhen: (previous, current) =>
                                        current is ImageLoadingState ||
                                        current is ImageLoadedState ||
                                        current is ImageErrorState,
                                    builder: (context, state) {
                                     
                                      if (state is ImageLoadedState) {
                                        if (profileCubit.base64Image != null) {
                                          final bytes = base64Decode(
                                              profileCubit.base64Image!);
                                          return Image.memory(
                                            bytes,
                                            fit: BoxFit.cover,
                                          );
                                        }
                                      }

                                      return CircleAvatar(
                                        maxRadius: 102,
                                        backgroundColor: Colors.grey,
                                        child: Container(
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          width: 200,
                                          height: 200,
                                          decoration: const ShapeDecoration(
                                              shape: CircleBorder()),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                profileCubit.userModel?.image ??
                                                    '',
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                const ShimmerPlaceHolder(),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                            const Positioned(
                              bottom: 16,
                              left: 16,
                              child: CircleAvatar(
                                  maxRadius: 16,
                                  backgroundColor: Colors.black87,
                                  child: Icon(Icons.edit)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      'Change Account Name',
                      style: AppStyles.bodyTextNormalRegular,
                    ),
                    AppTextFormField(
                      hintText: profileCubit.userModel!.name!,
                      controller: nameController,
                      prefixIcon: Icons.person,
                      validator: (value) {
                        if (!value.isNullOrEmpty()) {
                          if (value!.length < 3) {
                            return 'Please enter a valid name';
                          }
                        }
                        return null;
                      },
                    ),
                    Text(
                      'Change Email Address',
                      style: AppStyles.bodyTextNormalRegular,
                    ),
                    AppTextFormField(
                      hintText: profileCubit.userModel!.email!,
                      controller: emailController,
                      prefixIcon: Icons.email,
                      validator: (value) {
                        if (!value.isNullOrEmpty()) {
                          if (!AppRegex.isEmailValid(value!)) {
                            return 'Please enter a valid email';
                          }
                        }
                        return null;
                      },
                    ),
                    Text(
                      'Change Phone Number',
                      style: AppStyles.bodyTextNormalRegular,
                    ),
                    AppTextFormField(
                      hintText: profileCubit.userModel!.phone!,
                      controller: phoneController,
                      prefixIcon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (!value.isNullOrEmpty()) {
                          if (!AppRegex.isPhoneNumberValid(value!)) {
                            return 'Please enter a valid phone number';
                          }
                        }
                        return null;
                      },
                    ),
                    BlocConsumer<ProfileCubit, ProfileState>(
                        buildWhen: (previous, current) =>
                            current is UpdateProfileLoading ||
                            current is UpdateProfileSuccess ||
                            current is UpdateProfileError,
                        listenWhen: (previous, current) =>
                            current is UpdateProfileSuccess ||
                            current is UpdateProfileError,
                        listener: (context, state) {
                          if (state is UpdateProfileSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                appSnackBar(
                                    content: 'Data Updated Successfully',
                                    state: SnackBarState.success));
                          }
                          if (state is UpdateProfileError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                appSnackBar(
                                    content: 'Something Went Wrong',
                                    state: SnackBarState.error));
                          }
                        },
                        builder: (context, state) {
                          return state is UpdateProfileLoading
                              ? const Center(child: CircularProgressIndicator())
                              : AppButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      profileCubit.updateProfile(
                                        name: nameController.text.trim(),
                                        email: emailController.text.trim(),
                                        phone: phoneController.text.trim(),
                                        imageBase64: profileCubit.base64Image,
                                      );
                                    }
                                  },
                                  text: 'Update',
                                );
                        }),
                  ]),
            ),
          ),
        ));
  }
}
