import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/export.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_app_bar.dart';
import 'package:flutter_ecommerce_app/features/category/data/models/categories/category_response.dart';
import 'package:flutter_ecommerce_app/features/products/logic/proudcts_cubit/products_cubit.dart';
import 'package:flutter_ecommerce_app/features/products/logic/proudcts_cubit/products_states.dart';
import 'package:flutter_ecommerce_app/features/products/ui/products_screen/widgets/products_error_view.dart';
import 'package:flutter_ecommerce_app/features/products/ui/products_screen/widgets/produtcs_widgets/product_item_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsScreen extends StatefulWidget {
  final CategoryModel? categoryModel;
  const ProductsScreen({super.key, required this.categoryModel});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    ServiceLocator.productsCubit
        .getProducts(categoryId: widget.categoryModel?.id);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.categoryModel != null
            ? '${widget.categoryModel?.name?[0].toUpperCase()}${widget.categoryModel?.name!.substring(1)}'
            : 'Products',
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsetsDirectional.all(16),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            BlocBuilder<ProductsCubit, ProductsState>(
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
                    crossAxisCount: screenSize.width > 400 ? 4 : 2,
                    mainAxisSpacing: 13.h,
                    crossAxisSpacing: 12.w,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => const ProductShimmerLoading(),
                    childCount: screenSize.width > 400 ? 8 : 4,
                  ),
                );
              }

              // show products List
              if (state.status == ProductsStateStatus.productsSuccess) {
                if (state.productsList.isNullOrEmpty()) {
                  // show no result widget
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                }
                final productsByCategory = state.productsByCategoryList;

                return SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 244.h,
                    crossAxisCount: screenSize.width > 400 ? 4 : 2,
                    mainAxisSpacing: 13.h,
                    crossAxisSpacing: 12.w,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => ProductItemView(
                      productModel: productsByCategory?[index],
                      onProductClick: () {
                        context.pushNamed(
                          Routes.productDetailsScreen,
                          arguments: productsByCategory?[index].id,
                        );
                      },
                    ),
                    childCount: productsByCategory?.length,
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
            })
          ],
        ),
      ),
    );
  }
}
