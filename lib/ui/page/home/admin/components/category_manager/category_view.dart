// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/ui/page/home/admin/components/category_manager/components/dialog_category.dart';
import 'package:web_app/ui/page/home/admin/components/manufacturers_manager/components/dialog_manufacturer.dart';

import '../../../../../../constant.dart';
import '../../../../../component_common/my_dropdown_button2.dart';
import '../../../../../component_common/paginator_common.dart';
import '../../../../../component_common/textfield_common.dart';
import '../../../../../dialog/dialog_common.dart';
import 'category_view_model.dart';

class CategoryManagerView extends StatefulWidget {
  const CategoryManagerView({super.key});

  @override
  State<CategoryManagerView> createState() => _CategoryManagerViewState();
}

class _CategoryManagerViewState extends State<CategoryManagerView> {
  final viewModel = Get.find<CategoryViewModel>();

  final dialog = DialogCategory();

  final TextEditingController txtSearch = TextEditingController();
  RxInt tabIndex = 1.obs;
  // RxInt tabDesktopIndex = 0.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    txtSearch.addListener(() {
      final text = txtSearch.text.trim();
      print('text:' + text);
      viewModel.keyword.value = text;
      viewModel.getCategoryList();
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    txtSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SizedBox(
            //   height: 50,
            //   child: Obx(
            //     () => Row(
            //       children: [
            //         GestureDetector(
            //           onTap: () {
            //             tabIndex.value = 1;
            //           },
            //           child: Container(
            //             color: tabIndex.value == 1
            //                 ? Colors.blue
            //                 : Colors.transparent,
            //             padding: EdgeInsets.symmetric(horizontal: 10),
            //             child: Text('Tab1'),
            //           ),
            //         ),
            //         GestureDetector(
            //           onTap: () {
            //             tabIndex.value = 2;
            //           },
            //           child: Container(
            //             color: tabIndex.value == 2
            //                 ? Colors.blue
            //                 : Colors.transparent,
            //             padding: EdgeInsets.symmetric(horizontal: 10),
            //             child: Text('Tab2'),
            //           ),
            //         ),
            //         GestureDetector(
            //           onTap: () {
            //             tabIndex.value = 3;
            //           },
            //           child: Container(
            //             color: tabIndex.value == 3
            //                 ? Colors.blue
            //                 : Colors.transparent,
            //             padding: EdgeInsets.symmetric(horizontal: 10),
            //             child: Text('Tab3'),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  const Text(
                    'Danh sách danh mục:',
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: TextFieldCommon(
                      hintText: 'Tìm kiếm',
                      controller: txtSearch,
                      // onChanged: (value) {
                      //   viewModel.keyword.value = txtSearch.text.trim();
                      //   viewModel.getManufacturerList();
                      // },
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Obx(
                    () => IgnorePointer(
                      ignoring: viewModel.loading.value,
                      child: ElevatedButton(
                          onPressed: () {
                            dialog.showAddDialog(context);
                          },
                          child: const Text('Thêm danh mục')),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Obx(
                    () => MyDropdownButton2StateFull(
                      hint: '',
                      value: viewModel.selectedItem.value,
                      itemHeight: 20,
                      dropdownItems: pageStep,
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
                  SizedBox(
                    width: 80,
                    child: Text(
                      'ID',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Tên danh mục',
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
                          itemCount: viewModel.categoryList.value.length,
                          itemBuilder: (context, index) => Container(
                            color: index % 2 == 0
                                ? Colors.white
                                : Colors.blue.shade100,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    child: Text(
                                      '${viewModel.categoryList.value[index].id}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      viewModel
                                              .categoryList.value[index].name ??
                                          "",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            dialog.showUpdateDialog(
                                                context,
                                                viewModel
                                                    .categoryList.value[index]);
                                          },
                                          child: const Text('Sửa')),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red),
                                          onPressed: () {
                                            Get.find<DialogCommon>()
                                                .showDeleteConfirmation(
                                              context,
                                              text:
                                                  'danh mục ${viewModel.categoryList.value[index].name} với id: ${viewModel.categoryList.value[index].id}',
                                              () => null,
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
              () => Visibility(
                visible: !viewModel.loading.value,
                child: PaginatorCommon(
                  totalPage: viewModel.totalPage.value,
                  initPage: viewModel.currentPage.value - 1,
                  onPageChangeCallBack: (index) =>
                      viewModel.onPageChange(index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:tab_container/tab_container.dart';

// class ExamplePage extends StatefulWidget {
//   const ExamplePage({Key? key}) : super(key: key);

//   @override
//   _ExamplePageState createState() => _ExamplePageState();
// }

// class _ExamplePageState extends State<ExamplePage> {
//   late final TabContainerController _controller;
//   late TextTheme textTheme;

//   @override
//   void initState() {
//     _controller = TabContainerController(length: 3);
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     textTheme = Theme.of(context).textTheme;
//     super.didChangeDependencies();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Example'),
//       ),
//       body: SingleChildScrollView(
//         child: SizedBox(
//           height: 1000,
//           child: Column(
//             children: [
//               SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.9,
//                 child: AspectRatio(
//                   aspectRatio: 10 / 8,
//                   child: TabContainer(
//                     radius: 20,
//                     tabEdge: TabEdge.bottom,
//                     tabCurve: Curves.easeIn,
//                     transitionBuilder: (child, animation) {
//                       animation = CurvedAnimation(
//                           curve: Curves.easeIn, parent: animation);
//                       return SlideTransition(
//                         position: Tween(
//                           begin: const Offset(0.2, 0.0),
//                           end: const Offset(0.0, 0.0),
//                         ).animate(animation),
//                         child: FadeTransition(
//                           opacity: animation,
//                           child: child,
//                         ),
//                       );
//                     },
//                     colors: const <Color>[
//                       Color(0xfffa86be),
//                       Color(0xffa275e3),
//                       Color(0xff9aebed),
//                     ],
//                     selectedTextStyle:
//                         textTheme.bodyText2?.copyWith(fontSize: 15.0),
//                     unselectedTextStyle:
//                         textTheme.bodyText2?.copyWith(fontSize: 13.0),
//                     children: _getChildren1(),
//                     tabs: _getTabs1(),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   List<Widget> _getChildren1() {
//     List<CreditCardData> cards = kCreditCards
//         .map(
//           (e) => CreditCardData.fromJson(e),
//         )
//         .toList();

//     return cards.map((e) => CreditCard(data: e)).toList();
//   }

//   List<String> _getTabs1() {
//     List<CreditCardData> cards = kCreditCards
//         .map(
//           (e) => CreditCardData.fromJson(e),
//         )
//         .toList();

//     return cards
//         .map(
//           (e) => '*' + e.number.substring(e.number.length - 4, e.number.length),
//         )
//         .toList();
//   }
// }

// class CreditCard extends StatelessWidget {
//   final Color? color;
//   final CreditCardData data;

//   const CreditCard({
//     Key? key,
//     this.color,
//     required this.data,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20.0),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(14.0),
//       ),
//       child: Column(
//         children: [
//           Expanded(
//             flex: 2,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   data.bank,
//                 ),
//                 Icon(
//                   data.number[0] == '4'
//                       ? FontAwesome5Brands.cc_visa
//                       : data.number[0] == '5'
//                           ? FontAwesome5Brands.cc_mastercard
//                           : FontAwesome5Regular.question_circle,
//                   size: 36,
//                 ),
//               ],
//             ),
//           ),
//           const Spacer(flex: 2),
//           Expanded(
//             flex: 5,
//             child: Row(
//               children: [
//                 Text(
//                   data.number,
//                   style: const TextStyle(
//                     fontSize: 22.0,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text('Exp.'),
//                 const SizedBox(width: 4),
//                 Text(
//                   data.expiration,
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Row(
//               children: [
//                 Text(
//                   data.name,
//                   style: const TextStyle(
//                     fontSize: 16.0,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CreditCardData {
//   int index;
//   bool locked;
//   final String bank;
//   final String name;
//   final String number;
//   final String expiration;
//   final String cvc;

//   CreditCardData({
//     this.index = 0,
//     this.locked = false,
//     required this.bank,
//     required this.name,
//     required this.number,
//     required this.expiration,
//     required this.cvc,
//   });

//   factory CreditCardData.fromJson(Map<String, dynamic> json) => CreditCardData(
//         index: json['index'],
//         bank: json['bank'],
//         name: json['name'],
//         number: json['number'],
//         expiration: json['expiration'],
//         cvc: json['cvc'],
//       );
// }

// const List<Map<String, dynamic>> kCreditCards = [
//   {
//     'index': 0,
//     'bank': 'Aerarium',
//     'name': 'John Doe',
//     'number': '4540 1234 5678 2975',
//     'expiration': '11/25',
//     'cvc': '123',
//   },
//   {
//     'index': 1,
//     'bank': 'Aerarium',
//     'name': 'John Doe',
//     'number': '5450 8765 4321 6372',
//     'expiration': '07/24',
//     'cvc': '321',
//   },
//   {
//     'index': 2,
//     'bank': 'Aerarium',
//     'name': 'John Doe',
//     'number': '4540 4321 8765 7446',
//     'expiration': '09/23',
//     'cvc': '456',
//   },
// ];
