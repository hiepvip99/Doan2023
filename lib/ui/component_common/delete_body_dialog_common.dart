import 'package:flutter/material.dart';

class DeleteItemDialog extends StatelessWidget {
  final String itemName;
  final VoidCallback onDelete;

  const DeleteItemDialog({
    super.key,
    required this.itemName,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Xóa $itemName?'),
      content: Text('Bạn có chắc muốn xóa $itemName không?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Đóng Dialog
          },
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: onDelete,
          child: const Text('Xóa'),
        ),
      ],
    );
  }
}
