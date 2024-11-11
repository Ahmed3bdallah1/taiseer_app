import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/service/auth_service.dart';
import '../../../../../../core/service/image_picker_cropper.dart';
import '../../../../../../main.dart';
import '../../domain/use_cases/upload_file_use_case.dart';

final uploadFileNotifierProvider =
    StateNotifierProvider.autoDispose<UploadFileNotifier, String?>((ref) {
  return UploadFileNotifier(
    uploadFileUseCase: getIt<UploadFileUseCase>(),
    imagePickerCropper: getIt<ImagePickerService>(),
    currentImage: ref.read(userProvider)?.profilePhotoUrl,
  );
});
final uploadFileNotifierProvider2 = StateNotifierProvider.autoDispose
    .family<UploadFileNotifier, String?, String?>((ref, currentImage) {
  return UploadFileNotifier(
    uploadFileUseCase: getIt<UploadFileUseCase>(),
    imagePickerCropper: getIt<ImagePickerService>(),
    currentImage: currentImage,
  );
});

class UploadFileNotifier extends StateNotifier<String?> {
  final UploadFileUseCase uploadFileUseCase;
  final ImagePickerService imagePickerCropper;

  UploadFileNotifier(
      {required this.uploadFileUseCase,
      required this.imagePickerCropper,
      required String? currentImage})
      : super(currentImage);

  Future<File?> pickImage() async {
    return imagePickerCropper.pickImage(crop: true);
  }

  Future<String> uploadFile(File file) async {
    final res = await uploadFileUseCase.call(file);
    return res.fold((l) => throw l, (r) {
      state = r.filePath;
      return r.filePath;
    });
  }
}
