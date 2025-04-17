import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/export.dart';
import 'package:flutter_ecommerce_app/core/utils/app_regex.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_app_bar.dart';
import 'package:flutter_ecommerce_app/features/auth/data/models/user_model.dart';
import 'package:flutter_ecommerce_app/features/profile/logic/profile_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late UserModel userModel;

  late GlobalKey<FormState> formKey;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    userModel = context.read<ProfileCubit>().userModel;
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
                            builder: (context) =>SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal:  16.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Upload Image',
                                      style: AppStyles.bodyTextLargeRegular
                                          .copyWith(
                                          color: AppColors.neutralDark),
                                    ),
                                    verticalSpace(8),
                                    TextButton.icon(
                                      onPressed: () {
                                        context.read<ProfileCubit>().uploadImageFromCamera();
                                        context.pop();
                                      },
                                      label: Text(
                                        'Camera',
                                        style: AppStyles.bodyTextMediumRegular
                                            .copyWith(
                                            color: AppColors.neutralDark),
                                      ),
                                      icon: const Icon(
                                        Icons.camera_alt,
                                        color: AppColors.neutralDark,
                                      ),
                                    ),
                                    TextButton.icon(
                                      onPressed: () {
                                        context.read<ProfileCubit>().uploadImageFromGallery();
                                        context.pop();
                                      },
                                      label: Text('Gallery',
                                          style: AppStyles.bodyTextMediumRegular
                                              .copyWith(
                                              color: AppColors.neutralDark)),
                                      icon: const Icon(
                                        Icons.photo_library_rounded,
                                        color: AppColors.neutralDark,
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
                              maxRadius: 82,
                              backgroundColor: Colors.grey,
                              child: CircleAvatar(
                                maxRadius: 80,
                                backgroundColor: Colors.grey,
                                backgroundImage: CachedNetworkImageProvider(
                                    userModel.image ?? ''),
                              ),
                            ),
                            const Positioned(
                              bottom: 4,
                              left: 4,
                              child: CircleAvatar(
                                  maxRadius: 16,
                                  backgroundColor: Colors.black54,
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
                      hintText: userModel.name!,
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
                      hintText: userModel.email!,
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
                      hintText: userModel.phone!,
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
                    AppButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (nameController.text.isNullOrEmpty() &&
                              emailController.text.isNullOrEmpty() &&
                              phoneController.text.isNullOrEmpty()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                appSnackBar(
                                    content: 'Please Enter A New Values ',
                                    state: SnackBarState.error));

                            return;
                          }
                          context.read<ProfileCubit>().updateProfile(
                                name: nameController.text.trim(),
                                email: emailController.text.trim(),
                                phone: phoneController.text.trim(),
                              );
                        }
                      },
                      text: 'Update',
                    ),
                  ]),
            ),
          ),
        ));
  }
}
