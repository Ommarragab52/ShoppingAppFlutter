// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_cart_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCartData _$UpdateCartDataFromJson(Map<String, dynamic> json) =>
    UpdateCartData(
      cartItem: json['cart'] == null
          ? null
          : CartItem.fromJson(json['cart'] as Map<String, dynamic>),
      subTotal: (json['sub_total'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UpdateCartDataToJson(UpdateCartData instance) =>
    <String, dynamic>{
      'cart': instance.cartItem,
      'sub_total': instance.subTotal,
      'total': instance.total,
    };
