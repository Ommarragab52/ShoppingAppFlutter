import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/export.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_app_bar.dart';
import 'package:flutter_ecommerce_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:flutter_ecommerce_app/features/home_layout/logic/cubit/home_layout_cubit.dart';
import 'package:flutter_ecommerce_app/features/products/logic/product_details_cubit/product_details_cubit.dart';
import 'package:flutter_ecommerce_app/features/products/logic/product_details_cubit/product_details_states.dart';
import 'package:flutter_ecommerce_app/features/products/ui/products_screen/widgets/produtcs_widgets/favorite_icon_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  CarouselSliderController carouselController = CarouselSliderController();
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        if (state.status == ProductsDetailsStateStatus.loading) {
          return SafeArea(
              child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator()),
          ));
        }
        if (state.status == ProductsDetailsStateStatus.success) {
          final productModel = state.product;
          return Scaffold(
            appBar: CustomAppBar(title: productModel?.name ?? 'Product Screen'),
            body: Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                bottom: (kBottomNavigationBarHeight + 16).h,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 238.h,
                      child: CarouselSlider.builder(
                        carouselController: carouselController,
                        itemCount: productModel!.images!.length,
                        itemBuilder: (context, index, realIndex) =>
                            CachedNetworkImage(
                          imageUrl: productModel.images![index],
                          fit: BoxFit.contain,
                          placeholder: (context, url) => const ShimmerPlaceHolder(),
                          filterQuality: FilterQuality.low,
                        ),
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            currentPage = index;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    verticalSpace(8),
                    Center(
                      child: AnimatedSmoothIndicator(
                        activeIndex: currentPage,
                        count: productModel.images?.length ?? 5,
                        effect: ScrollingDotsEffect(
                          activeDotColor: productModel.images.isNullOrEmpty()
                              ? AppColors.neutralLight
                              : AppColors.primaryBlue,
                          dotColor: AppColors.neutralLight,
                          dotHeight: 8.h,
                          dotWidth: 8.w,
                        ),
                        onDotClicked: (index) {
                          setState(() {
                            currentPage = index;
                            carouselController.animateToPage(currentPage);
                          });
                        },
                      ),
                    ),
                    verticalSpace(16),
                    Row(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: width / 1.3),
                          child: Text(
                            productModel.name ?? '',
                            maxLines: 4,
                            style: AppStyles.headingH3.copyWith(
                              color: AppColors.neutralDark,
                              overflow: TextOverflow.ellipsis,
                              shadows: [
                                const BoxShadow(
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                  color: Colors.black26,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        FavoriteIconButton(productModel: productModel),
                      ],
                    ),
                    verticalSpace(12),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          color: index == 4
                              ? AppColors.neutralLight
                              : AppColors.primaryYellow,
                          size: 18.w,
                        ),
                      ),
                    ),
                    verticalSpace(12),
                    Row(children: [
                      Text(
                        '\$${productModel.price ?? 0}',
                        style: AppStyles.headingH3.copyWith(
                          color: AppColors.primaryBlue,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      horizontalSpace(16),
                      productModel.oldPrice != null &&
                              productModel.oldPrice != productModel.price
                          ? Text(
                              '\$${productModel.oldPrice ?? 0}',
                              style: AppStyles.headingH5.copyWith(
                                color: AppColors.neutralGrey,
                                overflow: TextOverflow.ellipsis,
                                decoration: TextDecoration.lineThrough,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ]),
                    verticalSpace(8),
                    Text(
                      'Description',
                      style: AppStyles.headingH5.copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    verticalSpace(6),
                    Text(
                      productModel.description ?? '',
                      style: AppStyles.bodyTextNormalRegular.copyWith(
                        color: AppColors.neutralGrey,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    verticalSpace(12),
                  ],
                ),
              ),
            ),
            bottomSheet: BlocConsumer<CartCubit, CartState>(
              listener: (context, state) {
                if (state is CartAddDeleteSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(appSnackBar(
                      content: state.message, state: SnackBarState.success));
                } else if (state is CartAddDeleteFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(appSnackBar(
                      content: state.error, state: SnackBarState.error));
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 16.w,
                    end: 16.w,
                    bottom: 16.h,
                  ),
                  child: productModel.inCart!
                      ? AppButton(
                          onPressed: () {
                            // context.read<HomeLayoutCubit>().changeIndex(index: 2);
                            // context.pop();
                          },
                          text: 'In Cart',
                        )
                      : AppButton(
                          onPressed: () {
                            ServiceLocator.cartCubit
                                .addDeleteCart(productModel.id!);
                            productModel.inCart = !productModel.inCart!;
                          },
                          text: 'Add To Cart',
                        ),
                );
              },
            ),
          );
        }
        if (state.status == ProductsDetailsStateStatus.error) {
          return const SafeArea(child: Center(child: Text('Error')));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
