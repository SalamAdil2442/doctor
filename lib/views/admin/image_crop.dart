import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_editor/image_editor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/core/shared/theme_lang_notifier.dart';
import 'package:tandrustito/localization/translate_keys.dart';

class SimpleCropRoute extends StatefulWidget {
  final File file;
  const SimpleCropRoute({Key? key, required this.file}) : super(key: key);
  @override
  _SimpleCropRouteState createState() => _SimpleCropRouteState();
}

class _SimpleCropRouteState extends State<SimpleCropRoute> {
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.crop, color: Colors.white),
              onPressed: () {
                cropImage();
              }),
          appBar: AppBar(title: Text(Trans.cropImage.trans())),
          body: ExtendedImage.file(
            widget.file,
            fit: BoxFit.contain,
            mode: ExtendedImageMode.editor,
            enableLoadState: true,
            cacheRawData: true,
            extendedImageEditorKey: editorKey,
            initEditorConfigHandler: (ExtendedImageState? state) {
              return EditorConfig(
                maxScale: 8.0,
                cropRectPadding: const EdgeInsets.all(20.0),
                hitTestSize: 20.0,
                initCropRectType: InitCropRectType.imageRect,
                cropAspectRatio: CropAspectRatios.ratio1_1,
              );
            },
          )),
    );
  }

  Future<void> cropImage() async {
    final Uint8List fileData = Uint8List.fromList(
        await cropImageDataWithNativeLibrary(state: editorKey.currentState!));

    final tempDir = await getTemporaryDirectory();
    log("tempDir.path ${tempDir.path}");
    final file = await File('${tempDir.path}/${DateTime.now()}image.jpg')
        .create(recursive: true);
    file.writeAsBytesSync(fileData);
    Halper.i.pop();
    ThemeLangNotifier.instance.setFile(file);
  }
}

Future<List<int>> cropImageDataWithNativeLibrary(
    {required ExtendedImageEditorState state}) async {
  log('native library start cropping');

  final Rect cropRect = state.getCropRect()!;
  final EditActionDetails action = state.editAction!;

  final int rotateAngle = action.rotateAngle.toInt();
  final bool flipHorizontal = action.flipY;
  final bool flipVertical = action.flipX;
  final Uint8List img = state.rawImageData;

  final ImageEditorOption option = ImageEditorOption();

  if (action.needCrop) {
    option.addOption(ClipOption.fromRect(cropRect));
  }

  if (action.needFlip) {
    option.addOption(
        FlipOption(horizontal: flipHorizontal, vertical: flipVertical));
  }

  if (action.hasRotateAngle) {
    option.addOption(RotateOption(rotateAngle));
  }

  final DateTime start = DateTime.now();
  final Uint8List? result =
      await ImageEditor.editImage(image: img, imageEditorOption: option);

  log('${DateTime.now().difference(start)} ：total time');
  return result!;
}
