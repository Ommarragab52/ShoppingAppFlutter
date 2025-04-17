import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/helpers/space_helper.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_styles.dart';

class PasswordValidation extends StatelessWidget {
  final bool hasLowerCase;
  final bool hasUpperCase;
  final bool hasSpecialCharacter;
  final bool hasNumber;
  final bool hasMinLength;
  const PasswordValidation(
      {super.key,
      required this.hasLowerCase,
      required this.hasUpperCase,
      required this.hasSpecialCharacter,
      required this.hasNumber,
      required this.hasMinLength});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildValidateItem(hasLowerCase, 'At least 1 lowercase letter'),
        buildValidateItem(hasUpperCase, 'At least 1 uppercase letter'),
        buildValidateItem(hasSpecialCharacter, 'At least 1 special character'),
        buildValidateItem(hasNumber, 'At least 1 number'),
        buildValidateItem(hasMinLength, 'At least 8 characters long'),
      ],
    );
  }

  Widget buildValidateItem(bool isValidCase, String text) {
    if (isValidCase) {
      return const SizedBox.shrink();
    } else {
      return Row(
        children: [
          CircleAvatar(
            backgroundColor:
                isValidCase ? AppColors.neutralGrey : AppColors.primaryRed,
            radius: 3,
          ),
          horizontalSpace(2),
          Text(
            text,
            style: AppStyles.headingH6.copyWith(
                color:
                    isValidCase ? AppColors.neutralGrey : AppColors.primaryRed,
                decoration: isValidCase ? TextDecoration.lineThrough : null,
                decorationColor: Colors.green,
                decorationThickness: isValidCase ? 2 : null),
          )
        ],
      );
    }
  }
}
