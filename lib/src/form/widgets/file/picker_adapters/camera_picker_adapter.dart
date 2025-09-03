import 'package:image_picker/image_picker.dart';

import '../file_data.dart';
import '../file_pick_settings.dart';
import '../format_bytes_to_string.dart';
import '../picker_adapter.dart';

class CameraPickerAdapter implements PickerAdapter {
  final ImageSource source;

  const CameraPickerAdapter(this.source);

  @override
  Future<List<FileData>?> grabFile(FilePickSettings settings) async {
    var file = await ImagePicker().pickImage(
      source: source,
      imageQuality: 100,
      maxHeight: settings.maxHeight,
      maxWidth: settings.maxWidth,
      requestFullMetadata: true,
    );

    if (file == null) return null;

    var bytes = await file.readAsBytes();
    var fileSize = bytes.length;

    if (settings.maxFileSize != null && fileSize > settings.maxFileSize!) {
      throw ("Image exceed max size allowed: (${convertByteToDisplay(settings.maxFileSize!)})");
    }

    var extentionToken = file.path.split(".");

    if (file.mimeType == null && extentionToken.length < 2) {
      throw "You have selected a curropted image";
    }

    return [
      FileData(
        name: file.name,
        data: bytes,
        mimeType: file.mimeType ?? "image/${extentionToken.last}",
        size: fileSize,
      ),
    ];
  }
}
