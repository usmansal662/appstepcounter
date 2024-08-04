import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class PickImage {
  static ImagePicker picker = ImagePicker();

  static Future<File?> pickImage({required ImageSource source}) async {
    File? imageFile;

    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      final dir = await getApplicationDocumentsDirectory();
      imageFile = File("${dir.path}/${DateTime.now()}.jpg");
      final bytes = await pickedFile.readAsBytes();
      imageFile.writeAsBytesSync(bytes);
    }

    return imageFile;
  }
}
