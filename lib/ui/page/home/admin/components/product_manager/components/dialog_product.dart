import 'package:flutter/material.dart';

import '../../../../../../component_common/delete_body_dialog_common.dart';

class DialogProduct {
  void showDeleteConfirmation(
      BuildContext context, int id, Function() onDelete) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteItemDialog(
          itemName: 'Sản phẩm có id: $id',
          onDelete: () {
            onDelete();
            // Xử lý xóa item ở đây
            Navigator.of(context).pop(); // Đóng dialog sau khi xóa
          },
        );
      },
    );
  }
}
