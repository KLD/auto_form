import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../abstract/auto_field_state.dart';
import '../abstract/auto_field_widget.dart';
import 'file/file_data.dart';
import 'file/file_pick_settings.dart';
import 'file/picker_adapters/camera_picker_adapter.dart';
import 'file/picker_adapters/file_picker_adapter.dart';
import 'file/preview_adapters/image_preview_adapter.dart';
import 'file/preview_adapters/pdf_preview_adapter.dart';

enum FileSource { gallery, camera, files }

const filePickerAdaptors = {
  FileSource.gallery: CameraPickerAdapter(ImageSource.gallery),
  FileSource.camera: CameraPickerAdapter(ImageSource.camera),
  FileSource.files: FilePickerAdapter(),
};

const previewDataAdaptors = {
  "pdf": PdfPreviewAdapter(),
  "png": ImagePreviewAdapter(),
  "jpg": ImagePreviewAdapter(),
  "jpeg": ImagePreviewAdapter(),
  "gif": ImagePreviewAdapter(),
  "bmp": ImagePreviewAdapter(),
  "webp": ImagePreviewAdapter(),
  "wbmp": ImagePreviewAdapter(),
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
    this.settings = const FilePickSettings.singleFile(),
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
    this.settings = const FilePickSettings.singleFile(),
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

    onValueSet.add((value) {
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
                            Positioned.directional(
                                textDirection: TextDirection.ltr,
                                top: -100,
                                start: -100,
                                child: Container(
                                  height: 13,
                                  width: 13,
                                  decoration: (BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.5),
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
      setValue("");
    }
    if (value.length == 1) {
      setValue(value.first);
    } else {
      setValue(jsonEncode(value.toList()));
    }
  }

  Widget buildPreview(FileData file) {
    var previewAdaptor = previewDataAdaptors[file.mimeType];

    if (previewAdaptor == null) {
      throw Exception("No preview adapter found for ${file.mimeType}");
    }
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
          builder: (context) => GestureDetector(
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
                              Navigator.pop(context, FileSource.gallery);
                            }),
                      if (widget.fileSource.contains(FileSource.camera))
                        ListTile(
                            title: const Text("Camera"),
                            onTap: () {
                              selectedSource = FileSource.camera;
                              Navigator.pop(context, FileSource.camera);
                            }),
                      if (widget.fileSource.contains(FileSource.files))
                        ListTile(
                            title: const Text("Files"),
                            onTap: () {
                              selectedSource = FileSource.files;
                              Navigator.pop(context, FileSource.files);
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
      var newFiles =
          await filePickerAdaptors[source]!.grabFile(widget.settings);
      if (newFiles == null) return;

      if (widget.settings.maxFileCount != null &&
          files.length + newFiles.length > widget.settings.maxFileCount!) {
        setError("Max file count exceeded");
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
      setError("Unexpected error occured");
    }
  }
}
