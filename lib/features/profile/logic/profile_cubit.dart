import 'dart:convert';
import 'dart:io';

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
  late UserModel userModel;

  void getLoginUser() async {
    emit(GetLoginUserLoading());
    final userJson =
        await SharedPref.getSecuredString(SharedPrefKeys.loginUser);
    if (userJson.isNotEmpty && userJson != null) {
      userModel = UserModel.fromJson(jsonDecode(userJson));
      emit(GetLoginUserSuccess(userModel));
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
      UpdateProfileRequest(name, email, phone, password, imageBase64),
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

  Future<XFile?> uploadImageFromGallery() async {
    // Pick image from gallery
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      // You can adjust quality to control file size
      imageQuality: 85,
    );

    return image;
  }

  Future<XFile?> uploadImageFromCamera() async {
    // Pick image from gallery
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      // You can adjust quality to control file size
      imageQuality: 85,
    );

    return image;
  }

  Future<String> convertImageToBase64(XFile image) async {
    // Read the file as bytes
    final File imageFile = File(image.path);
    final List<int> imageBytes = await imageFile.readAsBytes();

    // Convert bytes to base64 string
    final String base64Image = base64Encode(imageBytes);

    // Add prefix like "/9j/" as seen in your example
    // The "/9j/" prefix indicates it's a JPEG image in base64
    return "/9j/$base64Image";
  }
}
