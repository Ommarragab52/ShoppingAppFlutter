import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/export.dart';
import 'package:flutter_ecommerce_app/features/cart/data/models/cart_response/cart_item.dart';
import 'package:flutter_ecommerce_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CartItemView extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onCartClick;

  const CartItemView({
    super.key,
    required this.cartItem,
    required this.onCartClick,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: GestureDetector(
            onTap: onCartClick,
            child: Container(
              height: 110.h,
              alignment: Alignment.center,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.neutralLight),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: cartItem.product?.image ?? '',
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.low,
                    width: 72.w,
                    height: 72.h,
                  ),
                  horizontalSpace(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  cartItem.product?.name ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyles.headingH6,
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  ServiceLocator.cartCubit
                                      .addDeleteCart(cartItem.product!.id!);
                                },
                                icon: SvgPicture.asset(Assets.svgTrash),
                              )
                            ],
                          ),
                        ),
                        verticalSpace(12),
                        Flexible(
                          child: Row(
                            children: [
                              Text(
                                '\$${cartItem.quantity! * cartItem.product!.price!}',
                                style: AppStyles.headingH6.copyWith(
                                  color: AppColors.primaryBlue,
                                ),
                              ),
                              const Spacer(),
                              CartCounter(cartItem: cartItem),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CartCounter extends StatelessWidget {
  final CartItem cartItem;
  const CartCounter({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.h,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.neutralLight, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
            ),
            onPressed: () {
              if (cartItem.quantity! > 1) {
                ServiceLocator.cartCubit
                    .updateCart(cartItem, cartItem.quantity! - 1);
              }
            },
            icon: Icon(
              Icons.remove_rounded,
              size: 20.w,
              color: AppColors.neutralGrey,
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              vertical: 3.h,
              horizontal: 18.w,
            ),
            color: AppColors.neutralLight,
            child: Text(
              '${cartItem.quantity}',
              style: AppStyles.headingH6,
            ),
          ),
          IconButton(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
            ),
            onPressed: () {
              ServiceLocator.cartCubit
                  .updateCart(cartItem, cartItem.quantity! + 1);
            },
            icon: Icon(
              Icons.add_rounded,
              size: 20.w,
              color: AppColors.neutralGrey,
            ),
          )
        ],
      ),
    );
  }
}
