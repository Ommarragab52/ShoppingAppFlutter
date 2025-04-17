import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/export.dart';
import 'package:flutter_ecommerce_app/features/products/logic/proudcts_cubit/products_cubit.dart';
import 'package:flutter_ecommerce_app/features/products/logic/proudcts_cubit/products_states.dart';
import 'package:flutter_ecommerce_app/features/products/ui/products_screen/widgets/products_error_view.dart';
import 'package:flutter_ecommerce_app/features/products/ui/products_screen/widgets/produtcs_widgets/product_item_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsListGridView extends StatelessWidget {
  const ProductsListGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return BlocBuilder<ProductsCubit, ProductsState>(
        buildWhen: (previous, current) {
      return current.status == ProductsStateStatus.productsLoading ||
          current.status == ProductsStateStatus.productsSuccess ||
          current.status == ProductsStateStatus.productsError;
    }, builder: (context, state) {
      // Show shimmer loading
      if (state.status == ProductsStateStatus.productsLoading) {
        return SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 238.h,
            crossAxisCount: screenSize.width > 450 ? 4 : 2,
            mainAxisSpacing: 13.h,
            crossAxisSpacing: 12.w,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) => const ProductShimmerLoading(),
            childCount: screenSize.width > 450 ? 8 : 4,
          ),
        );
      }

      // show products List
      if (state.status == ProductsStateStatus.productsSuccess) {
        if (state.productsList.isNullOrEmpty()) {
          // show no result widgets
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
        final products = state.productsList;

        return SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 244.h,
            crossAxisCount: screenSize.width > 450 ? 4 : 2,
            mainAxisSpacing: 13.h,
            crossAxisSpacing: 12.w,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) => ProductItemView(
              productModel: products?[index],
              onProductClick: () {
                context.pushNamed(
                  Routes.productDetailsScreen,
                  arguments: products?[index].id,
                );
              },
            ),
            childCount: products?.length,
          ),
        );
      }

      // Show error
      if (state.status == ProductsStateStatus.productsError) {
        // need to fix
        return SliverToBoxAdapter(
            child: ProductsErrorView(
          errorMessage: state.errorMessage ?? '',
        ));
      }
      // Show no data result
      else {
        return const SizedBox.shrink();
      }
    });
  }
}
