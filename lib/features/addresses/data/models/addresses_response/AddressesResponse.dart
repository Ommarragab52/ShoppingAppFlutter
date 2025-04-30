import 'package:flutter_ecommerce_app/features/addresses/data/models/address_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'AddressesResponse.g.dart';

@JsonSerializable()
class AddressesResponse {
  AddressesResponse({
    this.status,
    this.message,
    this.addressData,
  });

  bool? status;
  dynamic message;
  @JsonKey(name: 'data')
  AddressData? addressData;

  factory AddressesResponse.fromJson(Map<String, dynamic> json) =>
      _$AddressesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddressesResponseToJson(this);
}

@JsonSerializable()
class AddressData {
  AddressData({
    this.currentPage,
    this.addressList,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  @JsonKey(name: 'data')
  List<AddressModel>? addressList;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory AddressData.fromJson(Map<String, dynamic> json) =>
      _$AddressDataFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDataToJson(this);
}


