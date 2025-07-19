import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'image_upload_state.dart';

class ImageUploadCubit extends Cubit<ImageUploadStateBase> {
  ImageUploadCubit() : super(ImageUploadInitial());

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    );
    if (image != null) {
      emit(ImageUploadSuccess(File(image.path)));
    }
  }

  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    );
    if (image != null) {
      emit(ImageUploadSuccess(File(image.path)));
    }
  }
}
