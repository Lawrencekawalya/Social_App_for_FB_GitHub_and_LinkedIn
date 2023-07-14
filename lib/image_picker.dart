import 'package:image_picker/image_picker.dart';
import 'dart:io';

Future<File?> pickImage() async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);

  if (pickedImage != null) {
    return File(pickedImage.path);
  }
  return null;
}
