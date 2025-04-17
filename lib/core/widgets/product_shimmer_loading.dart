import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/helpers/space_helper.dart';
import 'package:flutter_ecommerce_app/core/theming/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProductShimmerLoading extends StatelessWidget {
  const ProductShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Container(
        width: 138.w,
        height: 225.h,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: AppColors.neutralLight),
            borderRadius: BorderRadius.circular(5)),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade200,
          highlightColor: Colors.grey.shade300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 109.w,
                height: 109.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              verticalSpace(6),
              Container(
                height: 16.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              verticalSpace(6),
              Container(
                height: 16.h,
                width: 60.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              verticalSpace(6),
              Container(
                height: 12.h,
                width: 80.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
