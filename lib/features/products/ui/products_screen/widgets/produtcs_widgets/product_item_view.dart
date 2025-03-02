import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/export.dart';
import 'package:flutter_ecommerce_app/features/products/data/models/product_response/products_response.dart';
import 'package:flutter_ecommerce_app/features/products/logic/proudcts_cubit/products_cubit.dart';
import 'package:flutter_ecommerce_app/features/products/logic/proudcts_cubit/products_states.dart';
import 'package:flutter_ecommerce_app/features/products/ui/products_screen/widgets/produtcs_widgets/favorite_icon_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProductItemView extends StatefulWidget {
  final ProductModel? productModel;
  final bool? inFavoriteScreen;
  final Function()? onFavoriteDeleteClick;
  final Function() onProductClick;

  const ProductItemView({
    super.key,
    required this.productModel,
    this.inFavoriteScreen,
    this.onFavoriteDeleteClick,
    required this.onProductClick,
  });

  @override
  State<ProductItemView> createState() => _ProductItemViewState();
}

class _ProductItemViewState extends State<ProductItemView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onProductClick,
      child: Container(
        width: 144.w,
        height: 244.h,
        alignment: Alignment.center,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          border: Border.all(width: 1.5, color: AppColors.neutralLight),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.productModel?.image ?? '',
                    width: 109.w,
                    height: 109.h,
                    filterQuality: FilterQuality.low,
                    placeholder: (context, url) => buildShimmerPlaceholder(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  if (widget.inFavoriteScreen == null)
                    FavoriteIconButton(productModel: widget.productModel!),
                ],
              ),
            ),
            verticalSpace(8),
            Text(widget.productModel?.name ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.start,
                style: AppStyles.headingH6),
            verticalSpace(8),
            Flexible(
              child: Text(
                '\$${widget.productModel?.price}',
                overflow: TextOverflow.ellipsis,
                style: AppStyles.bodyTextNormalBold.copyWith(
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
            verticalSpace(8),
            Flexible(
              child: Row(
                children: [
                  if (widget.productModel?.discount != null &&
                      widget.productModel!.discount! > 0)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '\$${widget.productModel?.oldPrice}',
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.captionnormalregularline.copyWith(
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                        horizontalSpace(8),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '${widget.productModel?.discount}% Off',
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.captionnormalbold
                                .copyWith(color: AppColors.primaryRed),
                          ),
                        )
                      ],
                    ),
                  const Spacer(),
                  if (widget.inFavoriteScreen == true)
                    InkWell(
                      onTap: widget.onFavoriteDeleteClick,
                      child: SvgPicture.asset(Assets.svgTrash),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
