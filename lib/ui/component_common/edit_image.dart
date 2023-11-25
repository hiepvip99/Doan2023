// ignore_for_file: invalid_use_of_protected_member

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/ui/component_common/circle_button.dart';
import 'package:web_app/ui/page/home/admin/components/product_manager/product_manager_view.dart';

import '../../constant.dart';

class EditAvatarScreen extends StatelessWidget {
  EditAvatarScreen(
      {
    super.key,
    required this.image,
    required this.handleUpload,
  });

  final RxList<File> imageChoose = RxList();
  final String image;
  final Function(List<File> images) handleUpload;
  final Rx<File?> file = Rxn();
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // Hình ảnh avatar tròn
        // file.value
        Obx(
          () => file.value?.path != null
              ? Image.file(
                  file.value!,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.low,
                  height: 150,
                  width: 150,
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: ImageComponent(imageUrl: domain + image),
                ),
        ),
        // Biểu tượng chụp ảnh ở góc dưới bên phải
        Positioned(
          bottom: 8,
          right: 8,
          child: MyCircleButton(
            padding: const EdgeInsets.all(0),
            child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(50)),
                child: const Icon(Icons.camera_alt)),
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform
                  .pickFiles(allowMultiple: false, type: FileType.image);
              if (result != null) {
                imageChoose.value =
                    result.paths.map((path) => File(path ?? '')).toList();
                print(imageChoose.length);
                // ignore: invalid_use_of_protected_member
                handleUpload(imageChoose.value);
                file.value = imageChoose.value.first;
              }
            },
          ),
        ),
      ],
    );
  }
}
