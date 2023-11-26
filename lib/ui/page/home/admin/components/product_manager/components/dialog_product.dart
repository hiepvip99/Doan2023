// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_is_empty, invalid_use_of_protected_member
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
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

    RxString validateName = ''.obs;

    if (itemUpdate != null) {
      // for (var i = 0; i < colorSelected.length; i++) {
      // handle logic color
      if (itemUpdate.colors != null) {
        colorSelected.value = itemUpdate.colors!;
        if (itemUpdate.sizes != null) {
          sizeSelected.value = itemUpdate.sizes!;
        }
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
    TextEditingController txtMota =
        TextEditingController(text: product.description);
    // TextEditingController txtQuantity = TextEditingController();
    // TextEditingController txtPrice = TextEditingController();
    DialogCommon().showDialogWithBody(
      context,
      height: 600,
      width: 800,
      bodyDialog: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: itemUpdate != null,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 100, child: Text('Ảnh:')),
                  const SizedBox(
                    width: 20,
                  ),
                  ImageComponent(
                      imageUrl: domain +
                          (product.colors?.length != 0
                              ? product.colors?.first.images?.length != 0
                                  ? product.colors?.first.images?.first.url ??
                                      ''
                                  : ''
                              : ''))
                  // Image.memory(),
                ],
              ),
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
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 300,
                          child: TextFieldCommon(
                            controller: txtName,
                            border: validateName.value.isNotEmpty
                                ? const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red))
                                : null,
                          )),
                      validateName.value.isNotEmpty
                          ? Text(
                              validateName.value,
                              style: const TextStyle(color: Colors.red),
                            )
                          : const SizedBox(),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.blue.shade50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 100, child: Text('Màu sắc:')),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: 400,
                    child: Obx(
                      () => SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // ignore: invalid_use_of_protected_member
                          children: viewModel.colorList.value.map(
                            (e) {
                              final colorProductExist = colorSelected
                                  .where((item) => item.colorId == e.id)
                                  .toList();
                              final isSelected = colorProductExist.isNotEmpty;

                              final price = isSelected
                                  ? colorProductExist.first.price
                                  : 0;
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: CheckboxListTile(
                                          title: Tooltip(
                                            message: e.name,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    e.name ?? '',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Container(
                                                  height: 16,
                                                  width: 16,
                                                  decoration: BoxDecoration(
                                                      // border: Border.all(color: Colors.),
                                                      color: Color(int.parse(
                                                              '${e.colorCode}',
                                                              radix: 16) +
                                                          0xFF000000),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: Colors.black,
                                                          blurRadius: 8,
                                                          offset: Offset(0, 0),
                                                        ),
                                                      ]),
                                                ),
                                              ],
                                            ),
                                          ),
                                          value: isSelected,
                                          onChanged: (value) {
                                            if (value == true) {
                                              colorSelected.add(
                                                  ColorItemProduct(
                                                      colorId: e.id));
                                            } else {
                                              colorSelected.removeWhere(
                                                (element) =>
                                                    element.colorId == e.id,
                                              );
                                              if (colorSelected.length == 0) {
                                                sizeSelected.removeRange(
                                                    0, sizeSelected.length);
                                                sizeSelected.refresh();
                                              }
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
                                                  width: 250,
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
                SizedBox(
                  height: 400,
                  child: Obx(
                    () => SingleChildScrollView(
                      child: Column(
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
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: CheckboxListTile(
                                    title: Tooltip(
                                      message: e.name,
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
                                          (element) => (element.sizeId ==
                                              e.id) /* &&
                                              (element.colorId ==
                                                  sizevalueP?.colorId) */
                                          ,
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
                                        final quantity = sizeSelected
                                                .firstWhereOrNull(
                                                  (element) =>
                                                      (element.colorId ==
                                                          item.colorId) &&
                                                      (element.sizeId == e.id),
                                                )
                                                ?.quantity
                                                .toString() ??
                                            '';
                                        // final quantity =
                                        //     item.colorId == sizevalueP?.colorId
                                        //         ? sizevalueP?.quantity.toString()
                                        //         : '';
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
                                                  width: 150,
                                                  child: Tooltip(
                                                    message:
                                                        'Số lượng=> $colorName & ${e.name}:',
                                                    child: Text(
                                                        'Số lượng=> $colorName & ${e.name}:',
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
                                                            text: quantity),
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    onChanged: (value) {
                                                      // .quantity;
                                                      // sizeSelected.firstWhereOrNull((element) =>
                                                      //             (element.colorId ==
                                                      //                 item
                                                      //                     .colorId) &&
                                                      //             (element.sizeId ==
                                                      //                 e.id)) ==
                                                      //         null
                                                      //     ? sizeSelected.add(
                                                      //         SizeItemProduct(
                                                      //           sizeId: e.id,
                                                      //           colorId:
                                                      //               item.colorId,
                                                      //           quantity:
                                                      //               int.tryParse(
                                                      //                   value),
                                                      //         ),
                                                      //       )
                                                      //     : null;
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
              children: [
                const SizedBox(width: 100, child: Text('Mô tả sản phẩm:')),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                    width: 500,
                    child: TextFieldCommon(
                      controller: txtMota,
                      maxLines: 5,
                    ))
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
                      // if (itemUpdate != null) {
                      //   for (var element in colorSelected) {
                      //     element.productId = itemUpdate.id;
                      //   }
                      // }
                      validateName.value = '';
                      product.colors = colorSelected.value;
                      product.sizes = sizeSelected.value;

                      product.name = txtName.text.trim();
                      product.description = txtMota.text.trim();
                      if (product.name?.length != 0) {
                        if (colorSelected.value.length > 0 &&
                            sizeSelected.value.length > 0) {
                          if (itemUpdate != null) {
                            viewModel.updateProduct(product);
                          } else {
                            viewModel.addProduct(product);
                          }
                        } else {
                          DialogCommon().showAlertDialog(
                              context: context,
                              title: colorSelected.value.length > 0
                                  ? 'Bạn chưa chọn size'
                                  : 'Bạn chưa chọn màu sắc');
                        }
                      } else {
                        validateName.value = 'Tên không được để trống';
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

  void updateImageDialog(
      {required Product itemUpdate, required BuildContext context}) {
    DialogCommon().showDialogWithBody(
      context,
      height: 600,
      width: 800,
      title: 'Cập nhật hình ảnh sản phẩm có id: ${itemUpdate.id}',
      bodyDialog: Column(
        children: itemUpdate.colors?.length != 0
            ? itemUpdate.colors!.map(
                (e) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border:
                            Border.all(width: 1, color: Colors.grey.shade400)),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                            "Màu sắc: ${viewModel.colorList.firstWhereOrNull((element) => element.id == e.colorId)?.name ?? ''}"),
                        const SizedBox(
                          height: 20,
                        ),
                        Wrap(
                          children: e.images?.length != 0
                              ? e.images!
                                  .map((e) => ImageComponent(
                                      imageUrl: domain + (e.url ?? '')))
                                  .toList()
                              : [],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ChooseUploadImage(
                          viewModel: viewModel,
                          product: itemUpdate,
                          colorItemProduct: e,
                        )
                      ],
                    ),
                  );
                },
              ).toList()
            : [],
      ),
    );
  }
}

class ChooseUploadImage extends StatefulWidget {
  const ChooseUploadImage({
    super.key,
    required this.viewModel,
    required this.product,
    required this.colorItemProduct,
  });

  final ProductManagerViewModel viewModel;
  final Product product;
  final ColorItemProduct colorItemProduct;

  @override
  State<ChooseUploadImage> createState() => _ChooseUploadImageState();
}

class _ChooseUploadImageState extends State<ChooseUploadImage> {
  RxList<File> imageChoose = RxList();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Wrap(
              children: [
                ...imageChoose.value.map(
                  (element) => Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.blue)),
                    width: 170,
                    height: 170,
                    child: Stack(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.file(
                              element,
                              width: 150,
                              height: 150,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () => imageChoose.remove(element),
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform
                    .pickFiles(allowMultiple: true, type: FileType.image);
                if (result != null) {
                  imageChoose.value =
                      result.paths.map((path) => File(path ?? '')).toList();
                }
              },
              child: const Text('Chọn ảnh')),
          const SizedBox(
            height: 10,
          ),
          imageChoose.length > 0
              ? ElevatedButton(
                  onPressed: () {
                    final images = Images(
                        productIdUpload: widget.product.id,
                        infoUpload: widget.colorItemProduct,
                        listImageUpload: imageChoose.value);

                    widget.viewModel.uploadImage(images);
                  },
                  child: const Text('Upload'))
              : const SizedBox(),
        ],
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
