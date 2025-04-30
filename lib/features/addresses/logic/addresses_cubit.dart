import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/features/addresses/data/models/address_model.dart';
import 'package:flutter_ecommerce_app/features/addresses/data/repository/addresses_repository.dart';
import 'package:flutter_ecommerce_app/features/addresses/logic/addresses_state.dart';

class AddressesCubit extends Cubit<AddressState> {
  final AddressesRepository _addressesRepository;

  AddressesCubit(this._addressesRepository) : super(AddressState.initial());

  getAddresses() async {
    emit(state.copyWith(addressesStatus: Status.loading));
    final result = await _addressesRepository.getAddresses();
    result.when(
      success: (response) => emit(state.copyWith(
        addressesStatus: Status.success,
        addressesList: response.addressData?.addressList,
      )),
      failure: (error) => emit(state.copyWith(
        addressesStatus: Status.failure,
        addressesMsg: error.message,
      )),
    );
  }

  addAddress({
    required AddressModel addressModel,
  }) async {
    emit(state.copyWith(addAddressStatus: Status.loading));
    final result =
        await _addressesRepository.addAddress(addressModel: addressModel);
    result.when(
      success: (response) => emit(state.copyWith(
        addAddressStatus: Status.success,
        addAddressResponse: response.addressModel,
      )),
      failure: (error) => emit(state.copyWith(
        addAddressStatus: Status.failure,
        addAddressMsg: error.message,
      )),
    );
  }

  updateAddress({
    required int addressId,
    required AddressModel addressModel,
  }) async {
    emit(state.copyWith(updateAddressStatus: Status.loading));
    final result = await _addressesRepository.updateAddress(
      addressId: addressId,
      addressModel: addressModel,
    );
    result.when(
      success: (response) => emit(state.copyWith(
        updateAddressStatus: Status.success,
        updateAddressResponse: response.addressModel,
      )),
      failure: (error) => emit(state.copyWith(
        updateAddressStatus: Status.failure,
        updateAddressMsg: error.message,
      )),
    );
  }

  deleteAddress({
    required int addressId,
  }) async {
    emit(state.copyWith(deleteAddressStatus: Status.loading));
    final result = await _addressesRepository.deleteAddress(
      addressId: addressId,
    );
    result.when(
      success: (response) => emit(state.copyWith(
        deleteAddressStatus: Status.success,
        deleteAddressResponse: response.addressModel,
      )),
      failure: (error) => emit(state.copyWith(
        deleteAddressStatus: Status.failure,
        deleteAddressMsg: error.message,
      )),
    );
  }
}
