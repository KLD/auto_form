import 'file_data.dart';
import 'file_pick_settings.dart';

abstract class PickerAdapter {
  Future<List<FileData>?> grabFile(FilePickSettings settings);
}
