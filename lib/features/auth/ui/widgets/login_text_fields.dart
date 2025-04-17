import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/utils/app_regex.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/space_helper.dart';
import '../../../../core/widgets/app_text_form_filed.dart';
import '../../logic/auth_cubit.dart';
import 'password_validation.dart';

class LoginTextFields extends StatefulWidget {
  const LoginTextFields({super.key});

  @override
  State<LoginTextFields> createState() => _LoginTextFieldsState();
}

class _LoginTextFieldsState extends State<LoginTextFields> {
  var isPassword = true;
  bool showPasswordValidation = false;
  bool hasLowerCase = false;
  bool hasUpperCase = false;
  bool hasSpecialCharacter = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    passwordController = context.read<AuthCubit>().passwordController;
    setupPasswordValidationListener();
  }

  void setupPasswordValidationListener() {
    passwordController.addListener(
      () {
        setState(() {
          hasLowerCase = AppRegex.hasLowerCase(passwordController.text);
          hasUpperCase = AppRegex.hasUpperCase(passwordController.text);
          hasSpecialCharacter =
              AppRegex.hasSpecialCharacter(passwordController.text);
          hasNumber = AppRegex.hasNumber(passwordController.text);
          hasMinLength = AppRegex.hasMinLength(passwordController.text);
        });
      },
    );
  }

  bool isPasswordValid() {
    if (hasLowerCase == true &&
        hasUpperCase == true &&
        hasSpecialCharacter == true &&
        hasNumber == true &&
        hasMinLength == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: context.read<AuthCubit>().formKey,
        child: Column(
          children: [
            AppTextFormField(
                hintText: 'Email',
                controller: context.read<AuthCubit>().emailController,
                prefixIcon: Icons.email,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !AppRegex.isEmailValid(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                }),
            SizedBox(
              height: 8.h,
            ),
            AppTextFormField(
                hintText: 'Password',
                onTap: () {
                  setState(() {
                    showPasswordValidation = true;
                  });
                },
                isPassword: isPassword,
                prefixIcon: Icons.lock,
                sufixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPassword = !isPassword;
                    });
                  },
                  child: isPassword
                      ? const Icon(
                          Icons.visibility,
                        )
                      : const Icon(
                          Icons.visibility_off,
                        ),
                ),
                controller: context.read<AuthCubit>().passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty || !isPasswordValid()) {
                    return 'Please enter a valid password';
                  }
                  return null;
                }),
            verticalSpace(8),
            showPasswordValidation
                ? PasswordValidation(
                    hasLowerCase: hasLowerCase,
                    hasUpperCase: hasUpperCase,
                    hasSpecialCharacter: hasSpecialCharacter,
                    hasNumber: hasNumber,
                    hasMinLength: hasMinLength)
                : const SizedBox.shrink(),
          ],
        ));
  }
}
