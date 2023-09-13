// ignore_for_file: invalid_use_of_protected_member, prefer_is_empty

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/constant.dart';

import '../../../../../component_common/my_dropdown_button2.dart';
import '../../../../../component_common/paginator_common.dart';
import '../../../../../component_common/textfield_common.dart';
import 'product_manager_view_model.dart';

class ProductManagerView extends StatelessWidget {
  ProductManagerView({super.key});

  final ProductManagerViewModel viewModel = Get.find<ProductManagerViewModel>();

  static const router = '/ProductManager';

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
                        label: 'Tìm kiếm', controller: TextEditingController()),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        viewModel.showAdd(context);
                      },
                      child: const Text('Thêm sản phẩm')),
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
                  Expanded(
                    child: Text(
                      'ID',
                      overflow: TextOverflow.ellipsis,
                    ),
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
                    width: 121,
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
                                    Expanded(
                                      child: Text(
                                        '${viewModel.productList.value[index].id ?? 0}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
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
                                      child: Text(
                                        viewModel.productList.value[index]
                                                .name ??
                                            '',
                                        overflow: TextOverflow.ellipsis,
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
                                            onPressed: () {},
                                            child: const Text('Sửa')),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red),
                                            onPressed: () {
                                              if (viewModel.productList
                                                      .value[index].id !=
                                                  null) {
                                                viewModel.showDelete(
                                                  viewModel.productList
                                                      .value[index].id!,
                                                  context,
                                                );
                                              }
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
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 150,
        height: 150,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.low,
        errorWidget: (context, url, error) =>
            const SizedBox(width: 100, height: 200, child: Icon(Icons.error)),
      ),
    );
  }
}
