import 'package:auto_form_plus/src/form/widgets/file/format_bytes_to_string.dart';
import 'package:file_picker/file_picker.dart';

import '../file_data.dart';
import '../file_pick_settings.dart';
import '../picker_adapter.dart';

class FilePickerAdapter implements PickerAdapter {
  const FilePickerAdapter();
  @override
  Future<List<FileData>?> grabFile(FilePickSettings settings) async {
    var files = await FilePicker.platform.pickFiles(
        allowedExtensions: settings.allowedExtensions,
        allowMultiple: settings.maxFileCount != 1);

    if (files == null) return null;

    if (settings.maxFileCount != null &&
        files.files.length > settings.maxFileCount!) {
      throw ("Max file count exceeded");
    }

    if (settings.maxFileSize != null &&
        files.files.any((e) => e.size > settings.maxFileSize!)) {
      throw ("Some files exceed max size (${convertByteToDisplay(settings.maxFileSize!)})");
    }

    if (files.files.any((e) => e.extension == null)) {
      throw "You have selected a curropted file: ${files.files.firstWhere((e) => e.extension == null).name}";
    }

    return [
      for (var file in files.files)
        FileData(
            name: file.name,
            data: await file.xFile.readAsBytes(),
            mimeType: file.extension!,
            size: file.size)
    ];
  }
}
