import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/service/image_picker_cropper.dart';
import '../../../../../main.dart';
import '../../../../user_features/profile/domain/use_cases/upload_file_use_case.dart';

final uploadFileNotifierProvider =
    StateNotifierProvider.autoDispose<UploadFileNotifier, String?>((ref) {
  return UploadFileNotifier(
    uploadFileUseCase: getIt<UploadFileUseCase>(),
    imagePickerCropper: getIt<ImagePickerService>(),
  );
});
final uploadFileNotifierProvider2 = StateNotifierProvider.autoDispose
    .family<UploadFileNotifier, String?, String?>((ref, currentImage) {
  return UploadFileNotifier(
    uploadFileUseCase: getIt<UploadFileUseCase>(),
    imagePickerCropper: getIt<ImagePickerService>(),
  );
});

final uploadFileNotifierProvider3 = StateNotifierProvider
    .family<UploadFileNotifier, String?, String?>((ref, currentImage) {
  return UploadFileNotifier(
    uploadFileUseCase: getIt<UploadFileUseCase>(),
    imagePickerCropper: getIt<ImagePickerService>(),
  );
});

class UploadFileNotifier extends StateNotifier<String?> {
  final UploadFileUseCase uploadFileUseCase;
  final ImagePickerService imagePickerCropper;

  UploadFileNotifier(
      {required this.uploadFileUseCase, required this.imagePickerCropper})
      : super("");

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
//
// class PropertyProvider extends ChangeNotifier {
//   final List<Either<File, String>> _selectedImages = [];
//   bool isLoading = false;
//   final UploadFileUseCase uploadFileUseCase;
//   final ImagePickerService imagePickerCropper;
//
//   PropertyProvider(this.uploadFileUseCase, this.imagePickerCropper);
//
//   List<Either<File, String>> get selectedImages => _selectedImages;
//
//   Future<void> pickImages() async {
//     try {
//       final File? pickedFiles = await imagePickerCropper.pickImage();
//
//       if (pickedFiles != null) {
//         File? croppedFile =
//             await imagePickerCropper.cropImage(pickedFiles.path);
//
//         if (croppedFile != null) {
//           _selectedImages.add(Left(File(croppedFile.path)));
//         } else {
//           return;
//         }
//         notifyListeners();
//       }
//     } catch (e) {}
//   }
//
//   Future<String> _uploadImages() async {
//     if (_selectedImages.isEmpty) throw "Please Select Images";
//     if (_selectedImages.leftsEither().isEmpty) {
//       return jsonEncode([
//         ..._selectedImages.rightsEither(),
//       ]);
//     }
//     try {
//       final apiResponse = await uploadFileUseCase
//           .call(_selectedImages.leftsEither());
//       if (apiResponse.response != null &&
//           apiResponse.response?.statusCode == 200) {
//         final list = (apiResponse.response?.data['message'] as List)
//             .map((e) => e.toString())
//             .toList();
//         return jsonEncode([
//           ..._selectedImages.rightsEither().map((e) => e.toString()),
//           ...list,
//         ]);
//       } else {
//         throw "Failed To Upload Images";
//       }
//     } catch (e) {
//       throw "Failed To Upload Images";
//     }
//   }
//
//   _setLoading(bool val) {
//     isLoading = val;
//     notifyListeners();
//   }
//
//   void removeImage(int index) {
//     _selectedImages.removeAt(index);
//     notifyListeners();
//   }
// }
