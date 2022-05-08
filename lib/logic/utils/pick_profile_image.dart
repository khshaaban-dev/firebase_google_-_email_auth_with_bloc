import 'package:image_picker/image_picker.dart';

Future<String?> pickProfileImage() async {
  final image = await ImagePicker().pickImage(
    source: ImageSource.camera,
  );

  return image?.path;
}
