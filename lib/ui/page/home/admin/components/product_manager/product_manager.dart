// ignore_for_file: invalid_use_of_protected_member

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/ui/page/home/admin/components/product_manager/components/dialog_product.dart';

import '../../../../../component_common/textfield_common.dart';
import 'product_manager_view_model.dart';

class ProductManagerView extends StatelessWidget {
  ProductManagerView({super.key});

  final ProductManagerViewModel controller =
      Get.find<ProductManagerViewModel>();

  static const router = '/AccountManager';
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
                        // DialogAccount().showDialogAdd();
                      },
                      child: const Text('Thêm sản phẩm')),
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
                    width: 100,
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
              child: Container(
                // padding: const EdgeInsets.all(16),
                color: Colors.white54,
                child: Obx(
                  () => ListView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                    // shrinkWrap: true,
                    itemCount: controller.productList.value.length,
                    itemBuilder: (context, index) => Container(
                      color:
                          index % 2 == 0 ? Colors.white : Colors.blue.shade100,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '${controller.productList.value[index].id}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            CachedNetworkImage(
                                imageUrl:
                                    controller.productList.value[index].image,
                                width: 100,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.low),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                controller.productList.value[index].name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${controller.productList.value[index].quatity}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${controller.productList.value[index].price} đ',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                    onPressed: () {}, child: const Text('Sửa')),
                                const SizedBox(
                                  width: 8,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red),
                                    onPressed: () {
                                      controller.showDelete(
                                          controller
                                              .productList.value[index].id,
                                          context);
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
          ],
        ),
      ),
    );
  }
}
