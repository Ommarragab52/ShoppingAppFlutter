import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/export.dart';
import 'package:flutter_ecommerce_app/features/auth/data/models/user_model.dart';
import 'package:flutter_ecommerce_app/features/profile/data/models/update_profile_request.dart';
import 'package:flutter_ecommerce_app/features/profile/data/repository/profile_repository.dart';
import 'package:flutter_ecommerce_app/features/profile/logic/profile_state.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileCubit(this._profileRepository) : super(ProfileInitial());
   UserModel? userModel;
  String? base64Image;

  void getLoginUser() async {
    emit(GetLoginUserLoading());
    final userJson =
        await SharedPref.getSecuredString(SharedPrefKeys.loginUser);
    if (userJson.isNotEmpty && userJson != null) {
      userModel = UserModel.fromJson(jsonDecode(userJson));
      emit(GetLoginUserSuccess(userModel!));
    } else {
      emit(GetLoginUserError('user not found'));
    }
  }

  void updateProfile({
    String? name,
    String? email,
    String? phone,
    String? password,
    String? imageBase64,
  }) async {
    emit(UpdateProfileLoading());
    final response = await _profileRepository.updateProfile(
      UpdateProfileRequest(
        name.isNullOrEmpty() ? userModel?.name : name,
        email.isNullOrEmpty() ? userModel?.email : email,
        phone.isNullOrEmpty() ? userModel?.phone : phone,
        imageBase64,
      ),
    );
    response.when(
      success: (data) async {
        await SharedPref.setSecuredString(
            SharedPrefKeys.loginUser, jsonEncode(data.userModel!.toJson()));
        emit(UpdateProfileSuccess(data));
        getLoginUser();
      },
      failure: (error) {
        emit(UpdateProfileError(error.message));
      },
    );
  }

  void uploadNewImage({required bool fromGallery}) async {
    emit(ImageLoadingState());
    // Pick image from gallery
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: fromGallery ? ImageSource.gallery : ImageSource.camera,
      // You can adjust quality to control file size
      imageQuality: 50,
    );
    if (image != null) {
      base64Image = await convertImageToBase64(image);
      emit(ImageLoadedState('Image Loaded Successfully'));
    }else{
      emit(ImageErrorState('Please Select An Image'));
    }
  }

  Future<String> convertImageToBase64(XFile image) async {
    // Read the file as bytes
    final File imageFile = File(image.path);
    final List<int> imageBytes = await imageFile.readAsBytes();

    // Convert bytes to base64 string
    final String base64Image = base64Encode(imageBytes);
      debugPrint(base64Image);
    // Add prefix like "/9j/" as seen in your example
    // The "/9j/" prefix indicates it's a JPEG image in base64
    return base64Image;
  }
}
