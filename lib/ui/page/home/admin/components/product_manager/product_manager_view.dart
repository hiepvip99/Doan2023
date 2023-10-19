// ignore_for_file: invalid_use_of_protected_member, prefer_is_empty

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/constant.dart';

import '../../../../../component_common/my_dropdown_button2.dart';
import '../../../../../component_common/paginator_common.dart';
import '../../../../../component_common/textfield_common.dart';
import '../../../../../dialog/dialog_common.dart';
import 'components/dialog_product.dart';
import 'product_manager_view_model.dart';

class ProductManagerView extends StatefulWidget {
  const ProductManagerView({super.key});

  static const router = '/ProductManager';

  @override
  State<ProductManagerView> createState() => _ProductManagerViewState();
}

class _ProductManagerViewState extends State<ProductManagerView> {
  final ProductManagerViewModel viewModel = Get.find<ProductManagerViewModel>();

  final TextEditingController txtSearch = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    txtSearch.addListener(() {
      final text = txtSearch.text.trim();
      print('text:' + text);
      viewModel.keyword.value = text;
      viewModel.getAllProduct();
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  const Text(
                    'Danh sách sản phẩm:',
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    flex: 7,
                    child: TextFieldCommon(
                        label: 'Tìm kiếm', controller: txtSearch),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Obx(
                    () => IgnorePointer(
                      ignoring: viewModel.loading.value,
                      child: ElevatedButton(
                          onPressed: () {
                            DialogProduct(viewModel: viewModel)
                                .productDialog(context);
                          },
                          child: const Text('Thêm sản phẩm')),
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
                    width: 50,
                    child: Text(
                      'ID',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(
                      'Ảnh',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      'Tên Sản Phẩm',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Số lượng còn lại',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Giá',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 246,
                    child: Text('Chức năng'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => viewModel.loading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        // padding: const EdgeInsets.all(16),
                        color: Colors.white54,
                        child: Obx(
                          () => ListView.builder(
                            // physics: const NeverScrollableScrollPhysics(),
                            // shrinkWrap: true,
                            itemCount: viewModel.productList.value.length,
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
                                      width: 50,
                                      child: Tooltip(
                                        message: viewModel
                                            .productList.value[index].id
                                            ?.toString(),
                                        child: Text(
                                          '${viewModel.productList.value[index].id ?? 0}',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ImageComponent(
                                        imageUrl: viewModel
                                                    .productList
                                                    .value[index]
                                                    .colors
                                                    ?.length !=
                                                0
                                            ? viewModel
                                                        .productList
                                                        .value[index]
                                                        .colors
                                                        ?.first
                                                        .images
                                                        ?.length !=
                                                    0
                                                ? domain +
                                                    (viewModel
                                                            .productList
                                                            .value[index]
                                                            .colors
                                                            ?.first
                                                            .images
                                                            ?.first
                                                            .url ??
                                                        '')
                                                : ''
                                            : ''),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Tooltip(
                                        message: viewModel
                                            .productList.value[index].name,
                                        child: Text(
                                          viewModel.productList.value[index]
                                                  .name ??
                                              '',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        viewModel.productList.value[index].sizes
                                                    ?.length !=
                                                0
                                            ? '${viewModel.productList.value[index].sizes?.map((size) => size.quantity ?? 0).reduce((value, element) => value + element) ?? 0}'
                                            : '...',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        viewModel.productList.value[index]
                                                    .colors?.length !=
                                                0
                                            ? '${viewModel.productList.value[index].colors?.first.price ?? 0} đ'
                                            : '...đ',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              DialogProduct(
                                                      viewModel: viewModel)
                                                  .productDialog(context,
                                                      itemUpdate: viewModel
                                                          .productList
                                                          .value[index]);
                                            },
                                            child: const Text('Sửa')),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              DialogProduct(
                                                      viewModel: viewModel)
                                                  .updateImageDialog(
                                                itemUpdate: viewModel
                                                    .productList.value[index],
                                                context: context,
                                              );
                                            },
                                            child: const Text('Cập nhật ảnh')),
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
                                                    'sản phẩm ${viewModel.manufacturerList.value[index].name} với id: ${viewModel.manufacturerList.value[index].id}',
                                                () => viewModel.deleteProduct(
                                                    viewModel.productList
                                                        .value[index]),
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

class ImageComponent extends StatelessWidget {
  const ImageComponent({
    super.key,
    required this.imageUrl,
    this.isShowBorder = true,
  });

  final String imageUrl;
  final bool? isShowBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration:
          BoxDecoration(
          // color: Colors.grey,
          border: isShowBorder == false
              ? null
              : Border.all(width: 1, color: Colors.black)),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 150,
        height: 150,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.low,
        errorWidget: (context, url, error) =>
            const Center(child: Icon(Icons.error)),
      ),
    );
  }
}
