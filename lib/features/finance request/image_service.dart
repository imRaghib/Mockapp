import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class ImageService {
  File? imageFile;
  Uint8List? imageData;

  Future<(File?, Uint8List?)> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      imageFile = File(picked.path);
      imageData = await picked.readAsBytes();
      return (imageFile, imageData);
    }
    return (null, null);
  }
}
