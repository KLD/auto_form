import 'dart:typed_data';

class FileData {
  final String name;
  final Uint8List data;
  final String mimeType;
  final int size;

  const FileData({
    required this.name,
    required this.data,
    required this.mimeType,
    required this.size,
  });

  @override
  bool operator ==(Object other) {
    return other is FileData && other.hashCode == hashCode;
  }

  @override
  int get hashCode => data.reduce((value, element) => value + element).hashCode;
}
