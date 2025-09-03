import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../file_data.dart';
import '../file_preview_adapter.dart';

class PdfPreviewAdapter implements FilePreviewAdapter {
  const PdfPreviewAdapter();
  @override
  Widget preview(BuildContext context, FileData file) {
    return AbsorbPointer(
      child: SfPdfViewer.memory(
        file.data,
        canShowScrollHead: false,
        canShowPaginationDialog: false,
        canShowScrollStatus: false,
        enableDoubleTapZooming: false,
        enableTextSelection: false,
      ),
    );
  }
}
