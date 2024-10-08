import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../abstract/auto_field_state.dart';
import '../abstract/auto_field_widget.dart';

enum FileSource { gallery, camera, files }

const fileGrabAdaptors = {
  FileSource.gallery: CameraPickerAdapter(ImageSource.gallery),
  FileSource.camera: CameraPickerAdapter(ImageSource.camera),
  FileSource.files: FilePickerAdapter(),
};

const previewDataAdaptors = {
  "pdf": PdfPreviewAdapter(),
};

class AutoFileField extends AutoFieldWidget {
  final List<FileSource> fileSource;
  final FilePickSettings settings;

  final bool showFileName;

  AutoFileField({
    super.key,
    required super.id,
    required super.label,
    super.enabled = true,
    super.hidden = false,
    super.validations = const [],
    super.triggers = const [],
    super.initValue,
    this.fileSource = const [
      FileSource.gallery,
      FileSource.camera,
      FileSource.files
    ],
    this.settings = const FilePickSettings(),
    this.showFileName = false,
  });

  AutoFileField.image({
    super.key,
    required super.id,
    required super.label,
    super.enabled = true,
    super.hidden = false,
    super.validations = const [],
    super.triggers = const [],
    super.initValue,
    this.settings = const FilePickSettings(),
    this.showFileName = false,
  }) : fileSource = const [FileSource.camera, FileSource.gallery];

  AutoFileField.file({
    super.key,
    required super.id,
    required super.label,
    super.enabled = true,
    super.hidden = false,
    super.validations = const [],
    super.triggers = const [],
    super.initValue,
    this.settings = const FilePickSettings(),
    this.showFileName = false,
  }) : fileSource = const [FileSource.files];

  @override
  State<StatefulWidget> createState() => AutoFileState();
}

class AutoFileState extends AutoFieldState<AutoFileField> {
  final Set<FileData> files = {};

  bool get canAddMore =>
      widget.settings.maxFileCount == null ||
      files.length < widget.settings.maxFileCount!;

  @override
  void initState() {
    super.initState();

    widget.onValueSet.add((value) {
      setState(() {});
    });
  }

  @override
  Widget buildField(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        label: Text(widget.label),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Wrap(
              children: files
                  .map((file) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            SizedBox(
                              width: 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      clipBehavior: Clip.antiAlias,
                                      height: 120,
                                      child: buildPreview(file)),
                                  if (widget.showFileName)
                                    Text(
                                      file.name,
                                      style: const TextStyle(fontSize: 10),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                ],
                              ),
                            ),
                            Positioned(
                                child: Container(
                              height: 13,
                              width: 13,
                              decoration: (BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                shape: BoxShape.circle,
                              )),
                              child: GestureDetector(
                                onTap: () => setState(() {
                                  files.remove(file);
                                  updateFieldValue();
                                }),
                                child: const Icon(
                                  Icons.close,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ))
                          ],
                        ),
                      ))
                  .toList(),
            ),
            FilledButton(
                onPressed: canAddMore ? selectFileButtonHandler : null,
                child: const Text("Add")),
          ],
        ),
      ),
    );
  }

  void updateFieldValue() {
    var value = files
        .map((e) => UriData.fromBytes(e.data, mimeType: e.mimeType).toString());

    if (value.isEmpty) {
      widget.setValue("");
    }
    if (value.length == 1) {
      widget.setValue(value.first);
    } else {
      widget.setValue(jsonEncode(value.toList()));
    }
  }

  Widget buildPreview(FileData file) {
    var previewAdaptor =
        previewDataAdaptors[file.mimeType] ?? const ImagePreviewAdapter();
    return previewAdaptor.preview(context, file);
  }

  void selectFileButtonHandler() async {
    late FileSource source;
    if (widget.fileSource.length == 1) {
      source = widget.fileSource.first;
    } else {
      FileSource? selectedSource;
      var result = showModalBottomSheet(
          context: context,
          enableDrag: true,
          builder: (_) => GestureDetector(
                onTap: Navigator.of(context).pop,
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.fileSource.contains(FileSource.gallery))
                        ListTile(
                            title: const Text("Gallery"),
                            onTap: () {
                              selectedSource = FileSource.gallery;
                              Navigator.pop(_, FileSource.gallery);
                            }),
                      if (widget.fileSource.contains(FileSource.camera))
                        ListTile(
                            title: const Text("Camera"),
                            onTap: () {
                              selectedSource = FileSource.camera;
                              Navigator.pop(_, FileSource.camera);
                            }),
                      if (widget.fileSource.contains(FileSource.files))
                        ListTile(
                            title: const Text("Files"),
                            onTap: () {
                              selectedSource = FileSource.files;
                              Navigator.pop(_, FileSource.files);
                            }),
                    ],
                  ),
                ),
              ));

      await result;
      if (selectedSource == null) {
        return;
      }
      source = selectedSource!;
    }

    try {
      var newFiles = await fileGrabAdaptors[source]!.grabFile(widget.settings);
      if (newFiles == null) return;

      if (widget.settings.maxFileCount != null &&
          files.length + newFiles.length > widget.settings.maxFileCount!) {
        widget.setError("Max file count exceeded");
        return;
      }

      setState(() {
        int expecteeAddedFiles = files.length + newFiles.length;
        files.addAll(newFiles);
        updateFieldValue();

        if (files.length != expecteeAddedFiles) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Duplicate files were discarded"),
          ));
        }
      });
    } on String catch (msg) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(msg),
        ));
      }
    } catch (e) {
      widget.setError("Unexpected error occured");
    }
  }
}

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

abstract class PickerAdapter {
  Future<List<FileData>?> grabFile(FilePickSettings settings);
}

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

String convertByteToDisplay(int bytes) {
  if (bytes < 1024) {
    return "${bytes}B";
  } else if (bytes < 1024 * 1024) {
    return "${(bytes / 1024).toStringAsFixed(2)}KB";
  } else if (bytes < 1024 * 1024 * 1024) {
    return "${(bytes / 1024 / 1024).toStringAsFixed(2)}MB";
  } else {
    return "${(bytes / 1024 / 1024 / 1024).toStringAsFixed(2)}GB";
  }
}

abstract class FileExtentionPreviewAdapter {
  const FileExtentionPreviewAdapter();
  Widget preview(BuildContext context, FileData file);
}

class ImagePreviewAdapter implements FileExtentionPreviewAdapter {
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

class PdfPreviewAdapter implements FileExtentionPreviewAdapter {
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
