// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/model/network/account_model.dart';
import 'package:web_app/service/network/account_service.dart';
import 'package:web_app/ui/dialog/dialog_common.dart';

class AccountManagerViewModel extends GetxController {
  RxList<AccountInfo> accountList = RxList([]);
  RxList<Decentralization> decentralizationList = RxList([]);
  RxList<AccountStatus> accountStatusList = RxList([]);
  RxInt currentPage = 1.obs;
  RxInt totalPage = 1.obs;
  RxString selectedItem = '10'.obs;
  RxString keyword = ''.obs;
  RxBool loading = false.obs;

  // AccountInfo accountRegister = AccountInfo();

  AccountService networkService = AccountService();

  void onPageChange(int index) {
    currentPage.value = index + 1;
    getAccountList();
    print(currentPage.value);
  }

  void onStepChange(String? value) {
    selectedItem.value = value ?? '10';
    currentPage.value = 1;
    getAccountList();
  }

  @override
  void onInit() {
    super.onInit();
    // accountList.value = List.generate(
    //   20,
    //   (index) => AccountModel(
    //       id: index,
    //       email: 'abc@mail.com',
    //       fullName: 'Abc abc abc',
    //       role: index % 2 == 0 ? 0 : 1,
    //       userName: 'Admin'),
    // );
    getAccountList();
  }

  Future<void> getAccountList() async {
    loading.value = true;
    await networkService
        .getAllAccount(
            currentPage: currentPage.value,
            step: int.tryParse(selectedItem.value),
            keyword: keyword.value)
        .then((value) {
      if (value != null) {
        accountList.clear();
        accountList.value = value.accounts ?? [];
        decentralizationList.value = value.decentralization ?? [];
        accountStatusList.value = value.accountStatus ?? [];
        totalPage.value = value.totalPage ?? 1;
      }
    });
    loading.value = false;
  }

  String? getDecentralization(int? id) {
    final dataInList =
        decentralizationList.where((element) => element.id == id).toList();
    if (dataInList.isEmpty) {
      return "";
    }
    return dataInList[0].name;
  }

  Future<void> deleteAccount(
      AccountInfo accountDelete, BuildContext context) async {
    await networkService
        .deleteAccount(AccountsManagerModel(accountEdit: accountDelete))
        .then((value) async {
      if (value?.statusCode == 200) {
        getAccountList();
        await DialogCommon().showAlertDialog(
            context: context,
            title: 'Xóa thành công account có id: ${accountDelete.id}');
      } else {
        DialogCommon()
            .showAlertDialog(context: context, title: 'Lỗi xóa account');
      }
    });
  }

  Future<void> addAccount(AccountInfo account, BuildContext context) async {
    await networkService
        .addAccount(AccountsManagerModel(accountEdit: account))
        .then((value) {
      if (value?.statusCode == 200) {
        DialogCommon().showAlertDialog(
            context: context,
            title:
                'Thêm thành công account ${account.username}');
        getAccountList();
      } else {
        DialogCommon()
            .showAlertDialog(context: context, title: 'Lỗi thêm account');
      }
    });
  }

  Future<void> updateAccount(AccountInfo account, BuildContext context) async {
    await networkService
        .updateAccount(AccountsManagerModel(accountEdit: account))
        .then((value) {
      if (value?.statusCode == 200) {
        DialogCommon().showAlertDialog(
            context: context,
            title: 'Sửa thành công account có id: ${account.id}');
        getAccountList();
      } else {
        DialogCommon()
            .showAlertDialog(context: context, title: 'Lỗi sửa account');
      }
    });
  }
}
