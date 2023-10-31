import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/ui/component_common/edit_image.dart';
import 'package:web_app/ui/component_common/textfield_common.dart';

import '../../../../../../extendsion/extendsion.dart';
import '../../../../../component_common/button_beautiful.dart';
import '../../../../../component_common/textfield_beautiful.dart';
import '../../../admin/components/statistical/statistical_view.dart';
import 'address_manager/address_manager_view.dart';
import 'address_manager/address_manager_view_model.dart';
import 'my_profile_view_model.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static const route = '/EditProfileScreen';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final viewModel = Get.find<EditProfileViewModel>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  // final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setData();
  }

  void setData() {
    _nameController.text = viewModel.customerInfo.value.name ?? '';
    _phoneController.text = viewModel.customerInfo.value.phoneNumber ?? '';
    // _dobController.text = viewModel.customerInfo.value.phoneNumber ?? '';
    _emailController.text = viewModel.customerInfo.value.email ?? '';
    // _addressController.text = viewModel.customerInfo.value.address ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Chỉnh sửa thông tin'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Obx(
                  () => EditAvatarScreen(
                    image: viewModel.customerInfo.value.image ?? '',
                    handleUpload: (images) => viewModel.uploadImage(images),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFieldBeautiful(
                    title: 'Họ và tên', controller: _nameController),
                const SizedBox(
                  height: 16,
                ),
                TextFieldBeautiful(
                  title: 'Số điện thoại',
                  controller: _phoneController,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Row(
                  children: [
                    Text(
                      'Ngày sinh',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Divider(
                  height: 1.0,
                  color: Colors.grey[400],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text(
                        viewModel.customerInfo.value.dateOfBirth != null
                            ? formatDate(
                                viewModel.customerInfo.value.dateOfBirth!)
                            : '',
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   width: 20,
                    // ),
                    OutlinedButton(
                      onPressed: () {
                        showDatePicker(context);
                      },
                      child: const Row(
                        children: [
                          Text(
                            'Chọn ngày',
                            style: TextStyle(fontSize: 16),
                          ),
                          Icon(Icons.date_range),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 1.0,
                  color: Colors.grey[400],
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     const Text(
                //       'Ngày sinh',
                //       style: TextStyle(
                //         fontSize: 12,
                //         color: Colors.lightBlueAccent,
                //       ),
                //     ),
                //     const SizedBox(
                //       height: 5,
                //     ),
                //     // Theme(
                //     //   data: ThemeData(
                //     //       inputDecorationTheme: InputDecorationTheme(
                //     //     filled: true,
                //     //     fillColor: Colors.grey[200],
                //     //     contentPadding: const EdgeInsets.symmetric(
                //     //         vertical: 15, horizontal: 10),
                //     //     enabledBorder: OutlineInputBorder(
                //     //       borderSide: BorderSide.none,
                //     //       borderRadius: BorderRadius.circular(10),
                //     //     ),
                //     //     focusedBorder: OutlineInputBorder(
                //     //       borderSide:
                //     //           const BorderSide(color: Colors.lightBlueAccent),
                //     //       borderRadius: BorderRadius.circular(10),
                //     //     ),
                //     //   )),
                //     //   child: InputDatePickerFormField(
                //     //       errorFormatText: 'Bạn đã nhập sai định dạng',
                //     //       fieldLabelText: '',
                //     //       onDateSubmitted: (value) {
                //     //         print(value);
                //     //       },
                //     //       onDateSaved: (value) {
                //     //         print(value);
                //     //       },
                //     //       initialDate: viewModel.customerInfo.value.dateOfBirth,
                //     //       firstDate: DateTime(1950),
                //     //       lastDate: DateTime.now()),
                //     // ),
                //   ],
                // ),
                // TextFieldBeautiful(
                //   title: 'Ngày sinh',
                //   controller: _dobController,
                // ),
                const SizedBox(
                  height: 16,
                ),
                TextFieldBeautiful(
                  title: 'Email',
                  controller: _emailController,
                ),
                const SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(AddressManagerView.route,
                        arguments: AddressManagerViewArg(
                            addresses: viewModel.customerInfo.value.address ??
                                <String>[],
                            customerId: viewModel.customerInfo.value.id));
                  },
                  child: Column(
                    children: [
                      Divider(
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 12.0),
                      const Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Địa chỉ: ',
                              style: TextStyle(
                                fontSize: 16.0,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_right),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                      Divider(
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ),
                // TextFieldBeautiful(
                //   title: 'Địa chỉ',
                //   controller: _addressController,
                // ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                        child: ButtonBeautiful(
                      onTap: () {
                        // Xử lý khi nhấn nút Lưu
                        // Lấy giá trị từ các trường thông tin
                        String name = _nameController.text;
                        String phone = _phoneController.text;
                        // String dob = _dobController.text;
                        String email = _emailController.text;
                        // Dati
                        // String address = _addressController.text;
                        viewModel.customerInfo.value.name = name;
                        viewModel.customerInfo.value.phoneNumber = phone;
                        // viewModel.customerInfo.value.dateOfBirth =
                        //     DateTime.parse(dob);
                        viewModel.customerInfo.value.email = email;
                        // print('name: $name');
                        // Thực hiện lưu thông tin người dùng
                        // ...
                        viewModel.updateInfomation();
                        // Đưa người dùng trở lại màn hình trước đó
                      },
                      title: 'Lưu thông tin',
                    )),
                  ],
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showDatePicker(BuildContext context) {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: ScrollConfiguration(
            behavior: MyCustomScrollBehavior(),
            child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                use24hFormat: true,
                onDateTimeChanged: (value) {
                  viewModel.customerInfo.value.dateOfBirth = value;
                  viewModel.customerInfo.refresh();
                },
                initialDateTime: viewModel.customerInfo.value.dateOfBirth,
                minimumDate: DateTime(1990),
                maximumDate: DateTime(2050)),
          ),
        ),
      ),
    );
  }
}
