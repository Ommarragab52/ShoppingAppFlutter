import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/theming/app_styles.dart';

class RegisterTitleText extends StatelessWidget {
  const RegisterTitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Let’s Get Started', style: AppStyles.headingH4),
        Text('Create a new account', style: AppStyles.bodyTextNormalRegular),
      ],
    );
  }
}
