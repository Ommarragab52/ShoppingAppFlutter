import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/export.dart';
import 'package:flutter_ecommerce_app/core/utils/app_regex.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_app_bar.dart';
import 'package:flutter_ecommerce_app/features/auth/logic/auth_cubit.dart';
import 'package:flutter_ecommerce_app/features/auth/logic/auth_states.dart';
import 'package:flutter_ecommerce_app/features/auth/ui/widgets/password_validation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late AuthCubit authCubit;

  bool isField1Password = true;
  bool isField2Password = true;
  bool showPasswordValidation = false;

  bool hasLowerCase = false;
  bool hasUpperCase = false;
  bool hasSpecialCharacter = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  @override
  void initState() {
    super.initState();
    authCubit = context.read<AuthCubit>();
    authCubit.newPasswordController.addListener(
      () {
        setState(() {
          hasLowerCase =
              AppRegex.hasLowerCase(authCubit.newPasswordController.text);
          hasUpperCase =
              AppRegex.hasUpperCase(authCubit.newPasswordController.text);
          hasSpecialCharacter = AppRegex.hasSpecialCharacter(
              authCubit.newPasswordController.text);
          hasNumber = AppRegex.hasNumber(authCubit.newPasswordController.text);
          hasMinLength =
              AppRegex.hasMinLength(authCubit.newPasswordController.text);
        });
      },
    );
  }

  isValidPassword() {
    return hasLowerCase &&
        hasUpperCase &&
        hasSpecialCharacter &&
        hasNumber &&
        hasMinLength;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Change Password'),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              appSnackBar(
                content: state.message ?? 'Success',
                state: SnackBarState.success,
              ),
            );
          }
          if (state is ChangePasswordErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              appSnackBar(
                content: state.message ?? 'Error',
                state: SnackBarState.error,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Form(
                key: authCubit.formKey,
                child: Column(
                  spacing: 8.h,
                  children: [
                    AppTextFormField(
                      hintText: 'Current Password',
                      controller: authCubit.passwordController,
                      isPassword: isField1Password,
                      prefixIcon: Icons.lock,
                      sufixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isField1Password = !isField1Password;
                          });
                        },
                        child: isField1Password
                            ? const Icon(
                                Icons.visibility,
                              )
                            : const Icon(
                                Icons.visibility_off,
                              ),
                      ),
                      validator: (value) {
                        if (value.isNullOrEmpty()) {
                          return 'Please enter the current password';
                        }
                        return null;
                      },
                    ),
                    AppTextFormField(
                      hintText: 'New Password',
                      controller: authCubit.newPasswordController,
                      prefixIcon: Icons.lock,
                      isPassword: isField2Password,
                      sufixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isField2Password = !isField2Password;
                          });
                        },
                        child: isField2Password
                            ? const Icon(
                                Icons.visibility,
                              )
                            : const Icon(
                                Icons.visibility_off,
                              ),
                      ),
                      onTap: () {
                        setState(() {
                          showPasswordValidation = true;
                        });
                      },
                      validator: (value) {
                        if (value.isNullOrEmpty() || !isValidPassword()) {
                          return 'Please enter a valid password';
                        }
                        return null;
                      },
                    ),
                    showPasswordValidation
                        ? PasswordValidation(
                            hasLowerCase: hasLowerCase,
                            hasUpperCase: hasUpperCase,
                            hasSpecialCharacter: hasSpecialCharacter,
                            hasNumber: hasNumber,
                            hasMinLength: hasMinLength,
                          )
                        : const SizedBox.shrink(),
                    Container(
                        child: (state is ChangePasswordLoadingState)
                            ? const CircularProgressIndicator()
                            : AppButton(
                                onPressed: () {
                                  if (authCubit.formKey.currentState!
                                      .validate()) {
                                    authCubit.changePassword(
                                      currentPassword: authCubit
                                          .passwordController.text
                                          .trim(),
                                      newPassword: authCubit
                                          .newPasswordController.text
                                          .trim(),
                                    );
                                  }
                                },
                                text: 'Update Password',
                              ))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
