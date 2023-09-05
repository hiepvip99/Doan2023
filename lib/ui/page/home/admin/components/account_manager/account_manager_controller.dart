// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

class AccountManagerController extends GetxController {
  RxList<AccountModel> accountList = RxList([]);
  RxInt currentPage = 1.obs;
  RxInt totalPage = 10.obs;

  void onPageChange(int index) {
    currentPage.value = index + 1;
    print(currentPage.value);
  }

  @override
  void onInit() {
    super.onInit();
    accountList.value = List.generate(
      20,
      (index) => AccountModel(
          id: index,
          email: 'abc@mail.com',
          fullName: 'Abc abc abc',
          role: index % 2 == 0 ? 0 : 1,
          userName: 'Admin'),
    );
  }
}

class AccountModel {
  int id;
  String userName;
  String email;
  String fullName;
  int role;
  AccountModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.fullName,
    required this.role,
  });
}
