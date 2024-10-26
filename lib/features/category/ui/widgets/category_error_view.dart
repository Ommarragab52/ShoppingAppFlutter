import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/export.dart';
import 'package:flutter_ecommerce_app/features/category/export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CategoryErrorView extends StatelessWidget {
  final String errorMessage;
  const CategoryErrorView({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/not_found.svg',
            width: 120.w,
            height: 120.h,
          ),
          Text(
            errorMessage,
            style: AppStyles.bodyTextLargeBold,
            textAlign: TextAlign.center,
          ),
          verticalSpace(16),
          AppButton(
              onPressed: () {
                context.read<CategoryCubit>().getCategories();
              },
              text: 'Try Again')
        ],
      ),
    );
  }
}
