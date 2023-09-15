// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_is_empty
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Color, Size;
import 'package:flutter/services.dart' hide Size;
import 'package:get/get.dart';

import 'package:web_app/model/network/category_model.dart';
import 'package:web_app/ui/component_common/textfield_common.dart';

import '../../../../../../../constant.dart';
import '../../../../../../../model/network/color_model.dart';
import '../../../../../../../model/network/manufacturer_model.dart';
import '../../../../../../../model/network/product_manager_model.dart';
import '../../../../../../../model/network/size_model.dart';
import '../../../../../../component_common/dropdown_button_common.dart';
import '../../../../../../dialog/dialog_common.dart';
import '../../account_manager/components/dialog_account.dart';
import '../product_manager_view.dart';
import '../product_manager_view_model.dart';

class DialogProduct {
  final ProductManagerViewModel viewModel;
  DialogProduct({
    required this.viewModel,
  });

  List<String> genderList = ['Nam', 'Nữ'];

  void productDialog(BuildContext context, {Product? itemUpdate}) {
    RxList<ColorItemProduct> colorSelected = RxList();
    RxList<SizeItemProduct> sizeSelected = RxList();

    if (itemUpdate != null) {
      if (itemUpdate.sizes != null) {
        sizeSelected.value = itemUpdate.sizes!;
      }
      // for (var i = 0; i < colorSelected.length; i++) {
      // handle logic color
      if (itemUpdate.colors != null) {
        colorSelected.value = itemUpdate.colors!;
        // for (var j = 0; j < itemUpdate.colors!.length; j++) {
        //   if (colorSelected[i].color.id == itemUpdate.colors![j].colorId) {
        //     colorSelected[i].colorItemProduct = itemUpdate.colors![j];
        //     colorSelected[i].isSelected = true;
        //   }
        // }
      }
      // if (itemUpdate.sizes != null) {
      //   for (var element in itemUpdate.sizes!) {
      //     if (element.colorId == colorSelected[i].color.id) {
      //       colorSelected[i].sizeItemProduct = element;
      //     }
      //   }
      // }
      // }
    }
    Product product = itemUpdate ??
        Product(
            manufacturerId: viewModel.manufacturerList.first.id,
            // thieu category
            categoryId: viewModel.categoryList.first.id,
            gender: genderList.first);
    TextEditingController txtName = TextEditingController(text: product.name);
    // TextEditingController txtQuantity = TextEditingController();
    // TextEditingController txtPrice = TextEditingController();
    Get.find<DialogCommon>().showDialogWithBody(
      context,
      height: 600,
      width: 800,
      bodyDialog: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 100, child: Text('Ảnh:')),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () => viewModel.pickImage(
                      product.id,
                      product.colors?.length != 0
                          ? product.colors?.first
                          : null),
                  child: ImageComponent(
                      imageUrl: domain +
                          (product.colors?.length != 0
                              ? product.colors?.first.images?.length != null
                                  ? product.colors?.first.images?.first.url ??
                                      ''
                                  : ''
                              : '')),
                )
                // Image.memory(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            // Image.memory(),
            Row(
              children: [
                const SizedBox(width: 100, child: Text('Nhà sản xuất:')),
                const SizedBox(
                  width: 20,
                ),
                DropdownMenu<Manufacturer>(
                  initialSelection: product.manufacturerId != null
                      ? viewModel.manufacturerList
                          .where((e) => e.id == product.manufacturerId)
                          .toList()
                          .first
                      : viewModel.manufacturerList.first,
                  onSelected: (Manufacturer? value) {
                    if (value != null) {
                      product.manufacturerId = value.id;
                    }
                  },
                  dropdownMenuEntries: viewModel.manufacturerList
                      .map<DropdownMenuEntry<Manufacturer>>(
                    (Manufacturer value) {
                      return DropdownMenuEntry<Manufacturer>(
                          value: value, label: value.name ?? '');
                    },
                  ).toList(),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(width: 100, child: Text('Danh mục:')),
                const SizedBox(
                  width: 20,
                ),
                // todo: danh mục chưa làm
                DropdownMenu<Category>(
                    initialSelection: product.categoryId != null
                        ? viewModel.categoryList
                            .where((e) => e.id == product.categoryId)
                            .toList()
                            .first
                        : viewModel.categoryList.first,
                    onSelected: (Category? value) {
                      if (value != null) {
                        product.categoryId = value.id;
                      }
                    },
                    dropdownMenuEntries: viewModel.categoryList
                        .map<DropdownMenuEntry<Category>>((Category value) {
                      return DropdownMenuEntry<Category>(
                          value: value, label: value.name ?? '');
                    }).toList()),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(width: 100, child: Text('Tên sản phẩm:')),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                    width: 300, child: TextFieldCommon(controller: txtName))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.blue.shade100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 100, child: Text('Màu sắc:')),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: invalid_use_of_protected_member
                        children: viewModel.colorList.value.map(
                          (e) {
                            final colorProductExist = colorSelected
                                .where((item) => item.colorId == e.id)
                                .toList();
                            final isSelected = colorProductExist.isNotEmpty;

                            final price =
                                isSelected ? colorProductExist.first.price : 0;
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: CheckboxListTile(
                                        title: Tooltip(
                                          message: e.name,
                                          waitDuration:
                                              const Duration(seconds: 1),
                                          child: Text(
                                            e.name ?? '',
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        value: isSelected,
                                        onChanged: (value) {
                                          if (value == true) {
                                            colorSelected.add(ColorItemProduct(
                                                colorId: e.id));
                                          } else {
                                            colorSelected.removeWhere(
                                              (element) =>
                                                  element.colorId == e.id,
                                            );
                                          }
                                          colorSelected.refresh();
                                        },
                                      ),
                                    ),
                                    Visibility(
                                      visible: isSelected,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              SizedBox(
                                                width: 150,
                                                child: Tooltip(
                                                  waitDuration: const Duration(
                                                      seconds: 1),
                                                  message:
                                                      'Giá của màu ${e.name}',
                                                  child: Text(
                                                      'Giá của màu ${e.name}:',
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              SizedBox(
                                                width: 300,
                                                child: TextFieldCommon(
                                                  controller:
                                                      TextEditingController(
                                                          text:
                                                              '${price ?? ''}'),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  onChanged: (value) {
                                                    colorSelected
                                                            .firstWhere(
                                                                (element) =>
                                                                    element
                                                                        .colorId ==
                                                                    e.id)
                                                            .price =
                                                        int.tryParse(value);
                                                  },
                                                  keyboardType:
                                                      const TextInputType
                                                          .numberWithOptions(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 100, child: Text('Size giầy:')),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: invalid_use_of_protected_member
                      children: viewModel.sizeList.value.map(
                        (e) {
                          final sizeProductExist = sizeSelected
                              .where((item) => item.sizeId == e.id)
                              .toList();
                          final isSelected = sizeProductExist.isNotEmpty;
                          final SizeItemProduct? sizevalueP =
                              isSelected ? sizeProductExist.first : null;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 150,
                                child: CheckboxListTile(
                                  title: Tooltip(
                                    message: e.name,
                                    waitDuration: const Duration(seconds: 1),
                                    child: Text(
                                      e.name ?? '',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  value: isSelected,
                                  onChanged: (value) {
                                    if (value == true) {
                                      for (var elementItem in colorSelected) {
                                        sizeSelected.add(
                                          SizeItemProduct(
                                            sizeId: e.id,
                                            colorId: elementItem.colorId,
                                            quantity: 0,
                                          ),
                                        );
                                      }
                                    } else {
                                      sizeSelected.removeWhere(
                                        (element) => element.sizeId == e.id,
                                      );
                                    }
                                    sizeSelected.refresh();
                                  },
                                ),
                              ),
                              Visibility(
                                visible: isSelected,
                                child: Column(
                                  children: colorSelected.map(
                                    (item) {
                                      final colorName = viewModel.colorList
                                              .firstWhereOrNull((element) =>
                                                  element.id == item.colorId)
                                              ?.name ??
                                          '';
                                      // final sizeItem = sizeSelected.firstWhereOrNull((element) => element.colorId == item.colorId);
                                      final quantity =
                                          item.colorId == sizevalueP?.colorId
                                              ? sizevalueP?.quantity
                                              : 0;
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 200,
                                                child: Tooltip(
                                                  waitDuration: const Duration(
                                                      seconds: 1),
                                                  message:
                                                      'Số lượng của màu: $colorName với size = ${e.name}:',
                                                  child: Text(
                                                      'Số lượng của màu: $colorName với size = ${e.name}:',
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              SizedBox(
                                                width: 300,
                                                child: TextFieldCommon(
                                                  controller:
                                                      TextEditingController(
                                                          text:
                                                              '${quantity ?? 0}'),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  onChanged: (value) {
                                                    // .quantity;
                                                    sizeSelected
                                                            .firstWhere(
                                                              (element) =>
                                                                  (element.colorId ==
                                                                      item
                                                                          .colorId) &&
                                                                  (element.sizeId ==
                                                                      e.id),
                                                            )
                                                            .quantity =
                                                        int.tryParse(value);
                                                    print(sizeSelected
                                                        .firstWhere(
                                                          (element) =>
                                                              (element.colorId ==
                                                                  item
                                                                      .colorId) &&
                                                              (element.sizeId ==
                                                                  e.id),
                                                        )
                                                        .quantity);
                                                  },
                                                  keyboardType:
                                                      const TextInputType
                                                          .numberWithOptions(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            ],
                          );
                        },
                      ).toList(),
                    ),
                  ),
                )
              ],
            ),
            // Row(
            //   children: [
            //     const SizedBox(width: 100, child: Text('Size giầy:')),
            //     const SizedBox(
            //       width: 20,
            //     ),
            //     DropdownMenu<Category>(
            //         initialSelection: product.categoryId != null
            //             ? viewModel.categoryList
            //                 .where((e) => e.id == product.categoryId)
            //                 .toList()
            //                 .first
            //             : viewModel.categoryList.first,
            //         onSelected: (Category? value) {
            //           if (value != null) {
            //             product.categoryId = value.id;
            //           }
            //         },
            //         dropdownMenuEntries: viewModel.categoryList
            //             .map<DropdownMenuEntry<Category>>((Category value) {
            //           return DropdownMenuEntry<Category>(
            //               value: value, label: value.name ?? '');
            //         }).toList()),
            //   ],
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // Row(
            //   children: [
            //     const SizedBox(width: 100, child: Text('Số lượng:')),
            //     const SizedBox(
            //       width: 20,
            //     ),
            //     SizedBox(
            //         width: 300,
            //         child: TextFieldCommon(controller: TextEditingController()))
            //   ],
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // Row(
            //   children: [
            //     const SizedBox(width: 100, child: Text('Giá:')),
            //     const SizedBox(
            //       width: 20,
            //     ),
            //     SizedBox(
            //         width: 300,
            //         child: TextFieldCommon(controller: TextEditingController()))
            //   ],
            // ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(width: 100, child: Text('Giới tính')),
                const SizedBox(
                  width: 20,
                ),
                DropdownMenu<String>(
                    initialSelection: product.gender ?? genderList.first,
                    onSelected: (String? value) {
                      if (value != null) {
                        product.gender = value;
                      }
                    },
                    dropdownMenuEntries: genderList
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList()),
                // DropDownCustom(
                //   initValue: genderList.first,
                //   listItem: genderList,
                //   onChangeDropDown: (value) {
                //     itemAdd.value.gender = value;
                //   },
                // ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      // product.colors =
                      product.name = txtName.text.trim();
                      if (itemUpdate != null) {
                        viewModel.updateProduct(product);
                      } else {
                        viewModel.addProduct(product);
                      }
                    },
                    child: const Text('Submit')),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// class DataColor {
//   Color color;
//   bool isSelected;
//   ColorItemProduct colorItemProduct;
//   DataColor({
//     required this.color,
//     this.isSelected = false,
//     required this.colorItemProduct,
//   });
// }

// class DataSize {
//   Size size;
//   bool isSelected;
//   DataSize({
//     required this.size,
//     this.isSelected = false,
//   });
// }
