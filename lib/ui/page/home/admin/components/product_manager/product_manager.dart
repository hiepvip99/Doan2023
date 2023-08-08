import 'package:flutter/material.dart';

import '../../../../../component_common/textfield_common.dart';

class ProductManagerView extends StatelessWidget {
  const ProductManagerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  const Text(
                    'Danh sách tài khoản:',
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    flex: 7,
                    child: TextFieldCommon(
                        label: 'Tìm kiếm', controller: TextEditingController()),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // DialogAccount().showDialogAdd();
                      },
                      child: const Text('Thêm tài khoản')),
                ],
              ),
            ),
            Container(
              color: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'ID',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Tài khoản',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Họ và Tên',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Email',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Phân quyền',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 121,
                    child: Text('Chức năng'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                // padding: const EdgeInsets.all(16),
                color: Colors.white54,
                child: ListView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
                  // shrinkWrap: true,
                  // itemCount: controller.accountList.value.length,
                  itemBuilder: (context, index) => Container(
                    color: index % 2 == 0 ? Colors.white : Colors.blue.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Expanded(
                          //   child: Text(
                          //     '${controller.accountList.value[index].id}',
                          //     overflow: TextOverflow.ellipsis,
                          //   ),
                          // ),
                          // Expanded(
                          //   child: Text(
                          //     controller.accountList.value[index].userName,
                          //     overflow: TextOverflow.ellipsis,
                          //   ),
                          // ),
                          // Expanded(
                          //   child: Text(
                          //     controller.accountList.value[index].fullName,
                          //     overflow: TextOverflow.ellipsis,
                          //   ),
                          // ),
                          // Expanded(
                          //   child: Text(
                          //     controller.accountList.value[index].email,
                          //     overflow: TextOverflow.ellipsis,
                          //   ),
                          // ),
                          // Expanded(
                          //   child: Text(
                          //     controller.accountList.value[index].role > 0
                          //         ? 'User'
                          //         : 'Admin',
                          //     overflow: TextOverflow.ellipsis,
                          //   ),
                          // ),
                          // Row(
                          //   mainAxisSize: MainAxisSize.min,
                          //   children: [
                          //     ElevatedButton(
                          //         onPressed: () {}, child: const Text('Sửa')),
                          //     const SizedBox(
                          //       width: 8,
                          //     ),
                          //     ElevatedButton(
                          //         style: ElevatedButton.styleFrom(
                          //             backgroundColor: Colors.red),
                          //         onPressed: () {
                          //           DialogAccount()
                          //               .showDeleteConfirmation(context);
                          //         },
                          //         child: const Text('Xóa')),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
