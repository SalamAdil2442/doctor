import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/views/admin/image_crop.dart';
import 'package:tandrustito/views/home.dart';
import 'package:tandrustito/views/permissions_halper.dart';

selectImage(context) {
  showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
      // useRootNavigator: true,
      builder: (BuildContext context) {
        return SafeArea(
          maintainBottomViewPadding: true,
          top: true,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                ListTile(
                  leading: const Icon(
                    Icons.photo_camera,
                    color: primaryColor,
                  ),
                  title: Text(Trans.camera.trans()),
                  onTap: () async {
                    Halper.i.pop();
                    _pickImageCamera(ImageSource.camera);
                  },
                ),
                const SizedBox(height: 5),
                ListTile(
                  leading: const Icon(
                    Icons.photo_library,
                    color: primaryColor,
                  ),
                  title: Text(
                    Trans.gallery.trans(),
                  ),
                  onTap: () async {
                    Halper.i.pop();
                    _pickImageCamera(ImageSource.gallery);
                  },
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        );
      });
}

final picker = ImagePicker();

_pickImageCamera(ImageSource source) async {
  try {
    bool havePer = false;

    if (source == ImageSource.camera) {
      havePer = (await Permission.camera.request()).isGranted;
    } else {
      havePer = await PermissionHalper.instance.getStoreagePermission();
    }

    log("havePer $havePer");
    if (havePer) {
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        Navigator.push(
            Halper.i.context,
            MaterialPageRoute(
                builder: (_) => SimpleCropRoute(
                      file: File(pickedFile.path),
                    )));
      } else {
        log('No image selected.');
      }
    } else {}
  } catch (e) {
    log(e.toString());
  }
}
