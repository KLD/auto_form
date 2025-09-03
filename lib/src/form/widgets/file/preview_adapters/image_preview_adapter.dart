import 'package:flutter/material.dart';

import '../file_data.dart';
import '../file_preview_adapter.dart';

class ImagePreviewAdapter implements FilePreviewAdapter {
  const ImagePreviewAdapter();
  @override
  Widget preview(BuildContext context, FileData file) {
    return Image.memory(
      file.data,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => const Icon(Icons.block),
    );
  }
}
