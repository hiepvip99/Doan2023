// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_is_empty
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Color;
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:web_app/model/network/category_model.dart';
import 'package:web_app/ui/component_common/textfield_common.dart';

import '../../../../../../../constant.dart';
import '../../../../../../../model/network/color_model.dart';
import '../../../../../../../model/network/manufacturer_model.dart';
import '../../../../../../../model/network/product_manager_model.dart';
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
    RxList<DataColor> colorSelected = RxList();
    colorSelected.value = viewModel.colorList
        .map((element) => DataColor(
            color: element,
            colorItemProduct: ColorItemProduct(),
            sizeItemProduct: SizeItemProduct()))
        .toList();
    if (itemUpdate != null) {
      for (var i = 0; i < colorSelected.length; i++) {
        if (itemUpdate.colors != null) {
          for (var j = 0; j < itemUpdate.colors!.length; j++) {
            if (colorSelected[i].color.id == itemUpdate.colors![j].colorId) {
              colorSelected[i].colorItemProduct = itemUpdate.colors![j];
              colorSelected[i].isSelected = true;
            }
          }
        }
        if (itemUpdate.sizes != null) {
          for (var element in itemUpdate.sizes!) {
            if (element.colorId == colorSelected[i].color.id) {
              colorSelected[i].sizeItemProduct = element;
            }
          }
        }
      }
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

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 100, child: Text('Màu sắc:')),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Obx(
                    () => Wrap(
                      // ignore: invalid_use_of_protected_member
                      children: colorSelected.value
                          .map(
                            (e) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: CheckboxListTile(
                                    title: Tooltip(
                                      message: e.color.name,
                                      waitDuration: const Duration(seconds: 1),
                                      child: Text(
                                        e.color.name ?? '',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    value: e.isSelected,
                                    onChanged: (value) {
                                      if (value != null) {
                                        e.isSelected = value;
                                        colorSelected.refresh();
                                      }
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: e.isSelected,
                                  child: Column(
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
                                            child: Text(
                                              'Số lượng của màu ${e.color.name}:',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          SizedBox(
                                            width: 300,
                                            child: TextFieldCommon(
                                              controller: TextEditingController(
                                                  text:
                                                      '${e.sizeItemProduct?.quantity ?? ''}'),
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              keyboardType: const TextInputType
                                                  .numberWithOptions(),
                                              onChanged: (value) {
                                                e.sizeItemProduct!.quantity =
                                                    int.tryParse(value);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                                'Giá của màu ${e.color.name}:',
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          SizedBox(
                                            width: 300,
                                            child: TextFieldCommon(
                                              controller: TextEditingController(
                                                  text:
                                                      '${e.colorItemProduct?.price ?? ''}'),
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              keyboardType: const TextInputType
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
                          )
                          .toList(),
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

class DataColor {
  Color color;
  bool isSelected;
  ColorItemProduct? colorItemProduct;
  SizeItemProduct? sizeItemProduct;
  DataColor({
    required this.color,
    this.isSelected = false,
    this.colorItemProduct,
    this.sizeItemProduct,
  });
  // tao tung gia voi so luong ne
  // TextEditingController txtGia;
  // TextEditingController txtSoluong;
}
