// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/ui/component_common/button_beautiful.dart';
import 'package:web_app/ui/component_common/textfield_beautiful.dart';

import 'address_manager_view_model.dart';

class AddressManagerView extends StatefulWidget {
  const AddressManagerView({super.key});
  static const route = '/AddressManagerView';

  @override
  State<AddressManagerView> createState() => _AddressManagerViewState();
}

class _AddressManagerViewState extends State<AddressManagerView> {
  // List<String> viewModel.addresses.value = [];

  final viewModel = Get.find<AddressManagerViewModel>();

  void openAddAddressBottomSheet(BuildContext context) {
    TextEditingController addressTitleController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom, // Đẩy giao diện lên khi bàn phím xuất hiện
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFieldBeautiful(
                    autofocus: true,
                    title: 'Địa chỉ mới',
                    controller: addressTitleController),
                const SizedBox(height: 16),
                ButtonBeautiful(
                  title: 'Lưu',
                  onTap: () {
                    String newAddressTitle = addressTitleController.text;
                    if (newAddressTitle.isNotEmpty) {
                      viewModel.addAddress(newAddressTitle);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Quản lý địa chỉ'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: viewModel.addresses.value.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(viewModel.addresses.value[index]),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  viewModel.deleteAddress(index);
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Thêm địa chỉ mới'),
        // clipBehavior: Clip.antiAlias,
        onPressed: () {
          openAddAddressBottomSheet(context);
        },
        icon: const Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }
}
