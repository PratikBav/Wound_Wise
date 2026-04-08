import 'dart:io';
import 'package:image_picker/image_picker.dart';

/// Service for handling image capture and selection operations
class ImageService {
  final ImagePicker _picker = ImagePicker();

  /// Capture an image using the device camera
  /// Returns a File if successful, null if cancelled or failed
  Future<File?> captureImage() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (photo != null) {
        return File(photo.path);
      }
      return null; // User cancelled
    } catch (e) {
      // Error occurred (permission denied, camera unavailable, etc.)
      throw Exception(e.toString());
    }
  }

  /// Pick an image from the device gallery
  /// Returns a File if successful, null if cancelled or failed
  Future<File?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image != null) {
        return File(image.path);
      }
      return null; // User cancelled
    } catch (e) {
      // Error occurred (permission denied, etc.)
      throw Exception(e.toString());
    }
  }
}
