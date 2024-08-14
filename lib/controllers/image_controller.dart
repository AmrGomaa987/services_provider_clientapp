import 'package:get/get.dart';
import 'dart:io';

class ImageController extends GetxController {
  Rx<File?> image = Rx<File?>(null);

  void setImage(File? newImage) {
    image.value = newImage;
  }
}
