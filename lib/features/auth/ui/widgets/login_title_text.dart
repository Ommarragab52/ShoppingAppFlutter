import 'package:flutter/material.dart';

import '../../../../core/theming/app_styles.dart';

class LoginTitleText extends StatelessWidget {
  const LoginTitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Welcome Back', style: AppStyles.headingH4),
        Text('Sign in to continue', style: AppStyles.bodyTextNormalRegular),
      ],
    );
  }
}
