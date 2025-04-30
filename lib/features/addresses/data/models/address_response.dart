import 'package:flutter_ecommerce_app/features/addresses/data/models/address_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_response.g.dart';

@JsonSerializable()
class AddressResponse {
  AddressResponse({
    this.status,
    this.message,
    this.addressModel,
  });

  bool? status;
  String? message;
  @JsonKey(name: 'data')
  AddressModel? addressModel;

  factory AddressResponse.fromJson(Map<String, dynamic> json) =>
      _$AddressResponseFromJson(json);
}
