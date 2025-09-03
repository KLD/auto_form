class FilePickSettings {
  final List<String>? allowedExtensions;
  final int? maxFileCount;
  final int? maxFileSize;
  final double? maxHeight;
  final double? maxWidth;
  final int? imageQuality;

  const FilePickSettings({
    this.allowedExtensions,
    this.maxFileCount,
    this.maxFileSize,
    this.maxHeight,
    this.maxWidth,
    this.imageQuality,
  });

  const FilePickSettings.singleFile({
    this.allowedExtensions,
    this.maxFileSize,
    this.maxHeight,
    this.maxWidth,
    this.imageQuality,
  }) : maxFileCount = 1;
}
