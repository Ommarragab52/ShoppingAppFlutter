import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/export.dart';
import 'package:flutter_ecommerce_app/features/home/export.dart';
import 'package:flutter_ecommerce_app/features/products/logic/proudcts_cubit/products_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsCubit = context.read<ProductsCubit>();
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
        child: CustomScrollView(
          slivers: [
            // show Banners
            const SliverToBoxAdapter(child: BannersWidget()),
            SliverToBoxAdapter(
              child: CustomTextTitleAndButton(
                label: 'Flash Sale',
                haveButton: true,
                onPressed: () {
                  if (!productsCubit.state.saleProductsList.isNullOrEmpty()) {
                    // context.pushNamed(Routes.productsScreen);
                  }
                },
              ),
            ),
            // show sale products
            const SliverToBoxAdapter(
              child: SaleProductsWidget(),
            ),
            SliverToBoxAdapter(child: verticalSpace(24)),
            // show ad image
            const SliverToBoxAdapter(child: AdImageWidget()),
            SliverToBoxAdapter(child: verticalSpace(24)),
            SliverToBoxAdapter(
              child: CustomTextTitleAndButton(
                label: 'Products',
                haveButton: true,
                onPressed: () {
                  if (!productsCubit.state.productsList.isNullOrEmpty()) {
                    // context.pushNamed(Routes.productsScreen);
                  }
                },
              ),
            ),
            // show  products list
            const ProductsListGridView(),
          ],
        ),
      ),
    );
  }
}
