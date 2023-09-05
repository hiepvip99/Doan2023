// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:web_app/model/network/account_model.dart';
import 'package:web_app/service/network/account_service.dart';

class AccountManagerController extends GetxController {
  RxList<AccountInfo> accountList = RxList([]);
  RxList<Decentralization> decentralizationList = RxList([]);
  RxList<AccountStatus> accountStatusList = RxList([]);
  RxInt currentPage = 1.obs;
  RxInt totalPage = 10.obs;

  AccountService networkService = AccountService();

  void onPageChange(int index) {
    currentPage.value = index + 1;
    getAccountList();
    print(currentPage.value);
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
    await networkService.getAllAccount().then((value) {
      if (value != null) {
        accountList.clear();
        accountList.value = value.data ?? [];
        decentralizationList.value = value.decentralization ?? [];
        accountStatusList.value = value.accountStatus ?? [];
      }
    });
  }

  String? getDecentralization(int? id) {
    final dataInList =
        decentralizationList.where((element) => element.id == id).toList();
    if (dataInList.isEmpty) {
      return "";
    }
    return dataInList[0].name;
  }
}
