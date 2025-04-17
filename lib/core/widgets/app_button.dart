import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/export.dart';
import 'package:flutter_ecommerce_app/core/theming/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData? icon;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.borderRadius,
    this.backgroundColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      style: ButtonStyle(

        backgroundColor: WidgetStatePropertyAll(backgroundColor),
        padding: const WidgetStatePropertyAll(EdgeInsets.all(16)),
        minimumSize: WidgetStatePropertyAll(Size(double.infinity, 57.h)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius:
                borderRadius ?? BorderRadius.all(Radius.circular(8.r)),
          ),
        ),
      ),
      onPressed: onPressed,
      iconAlignment: IconAlignment.end,
      icon: icon == null ? null : Icon(icon),
      label: Text(
        text,
        style: AppStyles.buttonText,
      ),

    );
  }
}
