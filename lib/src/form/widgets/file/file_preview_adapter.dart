import 'package:flutter/material.dart';

import 'file_data.dart';

abstract class FilePreviewAdapter {
  const FilePreviewAdapter();
  Widget preview(BuildContext context, FileData file);
}
