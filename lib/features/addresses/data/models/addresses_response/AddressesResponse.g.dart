// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddressesResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressesResponse _$AddressesResponseFromJson(Map<String, dynamic> json) =>
    AddressesResponse(
      status: json['status'] as bool?,
      message: json['message'],
      addressData: json['data'] == null
          ? null
          : AddressData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddressesResponseToJson(AddressesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.addressData,
    };

AddressData _$AddressDataFromJson(Map<String, dynamic> json) => AddressData(
      currentPage: (json['currentPage'] as num?)?.toInt(),
      addressList: (json['data'] as List<dynamic>?)
          ?.map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      firstPageUrl: json['firstPageUrl'] as String?,
      from: (json['from'] as num?)?.toInt(),
      lastPage: (json['lastPage'] as num?)?.toInt(),
      lastPageUrl: json['lastPageUrl'] as String?,
      nextPageUrl: json['nextPageUrl'],
      path: json['path'] as String?,
      perPage: (json['perPage'] as num?)?.toInt(),
      prevPageUrl: json['prevPageUrl'],
      to: (json['to'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AddressDataToJson(AddressData instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'data': instance.addressList,
      'firstPageUrl': instance.firstPageUrl,
      'from': instance.from,
      'lastPage': instance.lastPage,
      'lastPageUrl': instance.lastPageUrl,
      'nextPageUrl': instance.nextPageUrl,
      'path': instance.path,
      'perPage': instance.perPage,
      'prevPageUrl': instance.prevPageUrl,
      'to': instance.to,
      'total': instance.total,
    };
