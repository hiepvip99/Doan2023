import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../component_common/close_button.dart';
import '../component_common/delete_body_dialog_common.dart';

class DialogCommon {
  // DialogCommon._privateConstructor();

  // static final DialogCommon _instance = DialogCommon._privateConstructor();

  // static DialogCommon get instance => _instance;

  bool isShowDialog = false;

  Future<void> showLoadingDialog() async {
    Get.dialog(
        const Center(
          child: SpinKitThreeBounce(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        barrierDismissible: false);
  }

  Future<void> showDialogWithBody(BuildContext context,
      {required Widget bodyDialog,
      double? width,
      double? height,
      EdgeInsets? padding,
    String? title,
    /* String? titleButtonSubmit,
    Function()? onSubmit, */
  }) async {
    Get.dialog(
      Center(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: width ?? 700, maxHeight: height ?? 500),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Scaffold(
              body: Padding(
                padding: padding ??
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            bodyDialog,
                          ],
                        ),
                      ),
                    ),
                    // titleButtonSubmit != null
                    //     ? ElevatedButton(
                    //         onPressed:
                    //             onSubmit != null ? () => onSubmit() : () {},
                    //         child: Text(titleButtonSubmit))
                    //     : const SizedBox()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      // context: context,
    );
  }

  void dismiss() async {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  static void showDialogErrorNetwork() {
    final context = Get.context;
    if (context != null) {
      DialogCommon().showAlertDialog(
          context: context,
          title: 'Vui lòng kết nối với mạng để thực hiện tính năng này');
    }
  }

  Future<void> showSuccessDialog(BuildContext context, String message) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thành công'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<void> showDeleteConfirmation(
    BuildContext context,
    Function() onDelete, {
    String? text,
    int? id,
    String? username,
  }) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteItemDialog(
          itemName: text ?? 'tài khoản: $username có id là: $id',
          onDelete: () {
            onDelete();
            // Xử lý xóa item ở đây
            Navigator.of(context).pop(); // Đóng dialog sau khi xóa
          },
        );
      },
    );
  }
  
  Future<void> showConfirmDialog(
    BuildContext context,
    String textConfirm,
    Function() onConfirm, {
    String? text,
  }) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$text'),
          // content: Text('$text'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng Dialog
              },
              child: const Text('Thoát'),
            ),
            ElevatedButton(
              onPressed: onConfirm,
              // style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text(textConfirm),
            ),
          ],
        );
      },
    );
  }

  Future<void> showAlertDialog({
    required BuildContext context,
    required String title,
    Color textColor = const Color(0xFF333333),
    Function()? close,
    String closeText = 'Đóng',
    double marginBottom = 0,
  }) async {
    showDialogWithBody(context,
        width: 300,
        height: 200,
        bodyDialog: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
        ));
    // await Future.delayed(
    //   const Duration(seconds: 3),
    //   () => dismiss(),
    // );
  }
}
