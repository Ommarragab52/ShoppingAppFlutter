import 'package:flutter_ecommerce_app/features/addresses/data/models/address_model.dart';

enum Status { initial, loading, success, failure }

class AddressState {
  // Addresses Status
  Status? addressesStatus;
  List<AddressModel>? addressesList;
  String? addressesMsg;

  // Add Address Status
  Status? addAddressStatus;
  AddressModel? addAddressResponse;
  String? addAddressMsg;

  // Update Address Status
  Status? updateAddressStatus;
  AddressModel? updateAddressResponse;
  String? updateAddressMsg;

  // Delete Address Status
  Status? deleteAddressStatus;
  AddressModel? deleteAddressResponse;
  String? deleteAddressMsg;

  AddressState._({
    this.addressesStatus,
    this.addressesList,
    this.addressesMsg,
    this.addAddressStatus,
    this.addAddressResponse,
    this.addAddressMsg,
    this.updateAddressStatus,
    this.updateAddressResponse,
    this.updateAddressMsg,
    this.deleteAddressStatus,
    this.deleteAddressResponse,
    this.deleteAddressMsg,
  });

  static AddressState initial() => AddressState._(
        addressesStatus: Status.initial,
        addressesList: null,
        addressesMsg: null,
        addAddressStatus: Status.initial,
        addAddressResponse: null,
        addAddressMsg: null,
        updateAddressStatus: Status.initial,
        updateAddressResponse: null,
        updateAddressMsg: null,
        deleteAddressStatus: Status.initial,
        deleteAddressResponse: null,
        deleteAddressMsg: null,
      );

  AddressState copyWith({
    Status? addressesStatus,
    List<AddressModel>? addressesList,
    String? addressesMsg,
    Status? addAddressStatus,
    AddressModel? addAddressResponse,
    String? addAddressMsg,
    Status? updateAddressStatus,
    AddressModel? updateAddressResponse,
    String? updateAddressMsg,
    Status? deleteAddressStatus,
    AddressModel? deleteAddressResponse,
    String? deleteAddressMsg,
  }) =>
      AddressState._(
        addressesStatus: addressesStatus ?? this.addressesStatus,
        addressesList: addressesList ?? this.addressesList,
        addressesMsg: addressesMsg ?? this.addressesMsg,
        addAddressStatus: addAddressStatus ?? this.addAddressStatus,
        addAddressResponse: addAddressResponse ?? this.addAddressResponse,
        addAddressMsg: addAddressMsg ?? this.addAddressMsg,
        updateAddressStatus: updateAddressStatus ?? this.updateAddressStatus,
        updateAddressResponse:
            updateAddressResponse ?? this.updateAddressResponse,
        updateAddressMsg: updateAddressMsg ?? this.updateAddressMsg,
        deleteAddressStatus: deleteAddressStatus ?? this.deleteAddressStatus,
        deleteAddressResponse:
            deleteAddressResponse ?? this.deleteAddressResponse,
        deleteAddressMsg: deleteAddressMsg ?? this.deleteAddressMsg,
      );

  @override
  String toString() {
    return 'AddressState(addressesStatus: $addressesStatus, addressesList: $addressesList, addressesMsg: $addressesMsg, addAddressStatus: $addAddressStatus, addAddressResponse: $addAddressResponse, addAddressMsg: $addAddressMsg, updateAddressStatus: $updateAddressStatus, updateAddressResponse: $updateAddressResponse, updateAddressMsg: $updateAddressMsg, deleteAddressStatus: $deleteAddressStatus, deleteAddressResponse: $deleteAddressResponse, deleteAddressMsg: $deleteAddressMsg)';
  }
}
