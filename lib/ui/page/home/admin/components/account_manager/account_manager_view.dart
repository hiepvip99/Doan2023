// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/ui/component_common/my_dropdown_button2.dart';
import 'package:web_app/ui/component_common/paginator_common.dart';
import 'package:web_app/ui/component_common/textfield_common.dart';

import 'account_manager_controller.dart';
import 'components/dialog_account.dart';

class AccountManagerView extends StatelessWidget {
  AccountManagerView({super.key});

  final AccountManagerViewModel viewModel = Get.find<AccountManagerViewModel>();

  static const router = '/AccountManager';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    // child: TextField(
                    //   decoration: InputDecoration(
                    //       label: Text('Tìm kiếm'),
                    //       border: OutlineInputBorder(),
                    //       contentPadding: EdgeInsets.all(8),
                    //       isDense: true),
                    // ),
                    child: TextFieldCommon(
                        hintText: 'Tìm kiếm',
                        controller: TextEditingController()),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        DialogAccount().showDialogAdd(context);
                      },
                      child: const Text('Thêm tài khoản')),
                  const SizedBox(
                    width: 50,
                  ),
                  Obx(
                    () => MyDropdownButton2StateFull(
                      hint: '',
                      value: viewModel.selectedItem.value,
                      itemHeight: 20,
                      dropdownItems: ["10", "20", "30", "50", "100", "500"],
                      onChanged: (value) {
                        if (value != null) {
                          viewModel.onStepChange(value);
                        }
                      },
                    ),
                  ),
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
                      'Tên Tài khoản',
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
                child: Obx(
                  () => viewModel.loading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                    // shrinkWrap: true,
                    itemCount: viewModel.accountList.value.length,
                    itemBuilder: (context, index) => Container(
                      color:
                          index % 2 == 0 ? Colors.white : Colors.blue.shade100,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '${viewModel.accountList.value[index].id}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                viewModel.accountList.value[index].username ??
                                    '',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                viewModel.accountList.value[index]
                                        .customerName ??
                                    '',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                viewModel.accountList.value[index].email ?? '',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                viewModel.getDecentralization(viewModel
                                        .accountList
                                        .value[index]
                                        .decentralizationId) ??
                                    '',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                    onPressed: () {}, child: const Text('Sửa')),
                                const SizedBox(
                                  width: 8,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red),
                                    onPressed: () {
                                      DialogAccount()
                                                .showDeleteConfirmation(
                                              context,
                                              viewModel
                                                  .accountList.value[index].id,
                                              viewModel.accountList.value[index]
                                                  .username,
                                              () => viewModel.deleteAccount(
                                                  viewModel
                                                      .accountList.value[index],
                                                  context),
                                            );
                                    },
                                    child: const Text('Xóa')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () => PaginatorCommon(
                totalPage: viewModel.totalPage.value,
                initPage: viewModel.currentPage.value - 1,
                onPageChangeCallBack: (index) => viewModel.onPageChange(index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
