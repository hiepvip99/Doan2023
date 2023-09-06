import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../component_common/close_button.dart';

class DialogCommon {
  // DialogCommon._privateConstructor();

  // static final DialogCommon _instance = DialogCommon._privateConstructor();

  // static DialogCommon get instance => _instance;

  bool isShowDialog = false;

  Future<void> showLoadingDialog() async {
    Get.dialog(const Center(
      child: SpinKitThreeBounce(
        color: Color.fromARGB(255, 255, 255, 255),
      ),
        ),
        barrierDismissible: false);
  }

  Future<void> showDialogWithBody(
      {required Widget bodyDialog,
      double? width,
      double? height,
      EdgeInsets? padding,
      String? title}) async {
    Get.dialog(Center(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: width ?? 600, maxHeight: height ?? 400),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Scaffold(
            body: Padding(
              padding: padding ??
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title ?? '',
                        style: Theme.of(Get.context!).textTheme.headlineSmall,
                      ),
                      const CloseButtonCommon()
                    ],
                  ),
                  bodyDialog,
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  void dismiss() async {
    if (Get.isDialogOpen ?? false) {
      Get.back(closeOverlays: true);
    }
  }

  static void showDialogErrorNetwork() {
    final context = Get.context;
    if (context != null) {
      Get.find<DialogCommon>().showAlertDialog(
          context: context,
          title: 'Vui lòng kết nối với mạng để thực hiện tính năng này');
    }
  }

  Future<void> showAlertDialog({
    required BuildContext context,
    required String title,
    Color textColor = const Color(0xFF333333),
    Function()? close,
    String closeText = 'Đóng',
    double marginBottom = 0,
  }) async {
    await showDialog(
      context: context,
      barrierColor: const Color(0xFF000000).withOpacity(0.5),
      builder: (context) => Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [BackButton()],
          ),
          Container(
            height: 300,
            width: 350,
            margin: EdgeInsets.only(bottom: marginBottom),
            child: Center(
              child: Text(title),
            ),
          ),
        ],
      ),
    );
  }
}
