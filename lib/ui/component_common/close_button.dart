import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CloseButtonCommon extends StatelessWidget {
  const CloseButtonCommon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          Icons.clear,
        ),
      ),
      onTap: () => Get.back(),
    );
  }
}
