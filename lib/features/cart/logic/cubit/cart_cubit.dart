import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/utils/app_extenstions.dart';
import 'package:flutter_ecommerce_app/features/cart/data/models/add_delete_cart/add_delete_cart_request.dart';
import 'package:flutter_ecommerce_app/features/cart/data/models/cart_response/cart_item.dart';
import 'package:flutter_ecommerce_app/features/cart/data/models/update_cart/update_cart_request.dart';
import 'package:flutter_ecommerce_app/features/cart/data/repo/cart_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository cartRepository;
  CartCubit(this.cartRepository) : super(CartInitial());

  Map<int, CartItem> cartMap = {};

  Future<void> getCarts() async {
    emit(CartGetDataLoading());
    final result = await cartRepository.getCart();
    result.when(
      success: (response) {
        final cartList = response.cartData?.cartItems ?? [];
        cartMap.addEntries(cartList.map(
          (e) {
            return MapEntry(e.id!, e);
          },
        ));

        emit(CartGetDataSuccess(cartMap));
      },
      failure: (error) {
        emit(CartGetDataFailure(error.message ?? 'Unknown error occured'));
      },
    );
  }

  Future<void> addDeleteCart(
    int productId,
  ) async {
    emit(CartAddDeleteLoading());
    final result =
        await cartRepository.addDeleteCart(AddDeleteCartRequest(productId));
    result.when(
      success: (response) {
        if (getCartItemByProductId(productId) != null) {
          final cartItem = getCartItemByProductId(productId)!;
          cartMap.remove(cartItem.id!);
        } else {
          cartMap.addAll({response.cartItem!.id!: response.cartItem!});
        }
        final message = response.message ?? 'successfully';
        emit(CartAddDeleteSuccess(message));
      },
      failure: (error) {
        emit(CartAddDeleteFailure(error.message ?? 'Unknown error occured'));
      },
    );
  }

  Future<void> updateCart(
    CartItem cartItem,
    int quantity,
  ) async {
    emit(CartUpdateLoading());
    final result = await cartRepository.updateCart(
        cartItem.id!, UpdateCartRequest(quantity));
    result.when(
      success: (response) {
        cartMap[cartItem.id!] = CartItem(
          id: cartItem.id,
          product: cartItem.product,
          quantity: quantity,
        );
        final message = response.message ?? 'successfully';
        emit(CartUpdateSuccess(message));
      },
      failure: (error) {
        emit(CartUpdateFailure(error.message ?? 'Unknown error occured'));
      },
    );
  }

  CartItem? getCartItemByProductId(int productId) {
    for (var cartItem in cartMap.values.toList()) {
      if (cartItem.product!.id! == productId) {
        return cartItem;
      }
    }
    return null;
  }

  int getCartTotalItems() {
    int total = 0;
    for (var cartItem in cartMap.values.toList()) {
      total += cartItem.quantity!;
    }
    return total;
  }

  double getTotalPrice() {
    double total = 0;
    for (var cartItem in cartMap.values.toList()) {
      total += cartItem.product!.price! * cartItem.quantity!;
    }
    return total;
  }

  final cuponCodeformKey = GlobalKey<FormState>();
  final cuponCodeController = TextEditingController();
  bool isValidCupon = false;
  String? validateCuponCode(String? value) {
    if (value.isNullOrEmpty()) {
      return '* Your Cupon Is Not Correct ';
    }
    if (value == 'off50') return null;
    return '* Your Cupon Is Not Correct ';
  }
}
