import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/constant.dart';

import '../../admin/components/product_manager/product_manager_view.dart';
import 'components/checkbox.dart';
import 'product_view_model.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  static String route = '/ProductView';

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final viewModel = Get.find<ProductViewModel>();

  final RxInt indexColorImage = 0.obs;
  final RxInt indexImage = 1.obs;
  final RxInt indexSizeCkecked = 1.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart))
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  color: Colors.black,
                  child: Stack(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            indexImage.value = index + 1;
                          },
                        ),
                        items: (viewModel.product.colors != null &&
                                viewModel.product.colors![indexColorImage.value]
                                        .images !=
                                    null)
                            ? viewModel
                                .product.colors![indexColorImage.value].images!
                                .map(
                                  (item) => ImageComponent(
                                      isShowBorder: false,
                                      imageUrl: domain + (item.url ?? '')),
                                )
                                .toList()
                            : [],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(8)),
                            child: Obx(() => Text(
                                '${indexImage.value} / ${viewModel.product.colors?[indexColorImage.value].images?.length ?? 1}')),
                          ),
                        ),
                      )
                    ],
                  )),
              // Container(
              //   color: Colors.orange,
              //   height: 300,
              //   child: Text('Image profduct'),
              // ),
              // const SizedBox(
              //   height: 16,
              // ),
              // Container(
              //     color: Colors.amber, child: const Text('Danh sasch anh')),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Product name'),
                  GestureDetector(
                    onTap: () =>
                        viewModel.favorite.value = !viewModel.favorite.value,
                    child: Obx(
                      () => Icon(
                        viewModel.favorite.value
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: viewModel.favorite.value
                            ? Colors.red
                            : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Nhaf san xuat : Nike'),
              const SizedBox(
                height: 16,
              ),
              Obx(
                () => Wrap(
                  children: [
                    const Text('Màu sắc:'),
                    if (viewModel.product.colors != null)
                      ...viewModel.product.colors!
                          .map((e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: OutlinedButton(
                                    onPressed: () {},
                                    // ignore: invalid_use_of_protected_member
                                    child: Text(viewModel.colorList.value
                                            .firstWhereOrNull((element) =>
                                                element.id == e.colorId)
                                            ?.name ??
                                        'chưa có name ?')),
                              ))
                          .toList()
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Wrap(
                children: [
                  CustomCheckbox(
                    text: 'test',
                    isChecked: true,
                  ),
                ],
              ),
              // Container(color: Colors.purple, child: const Text('chon size')),
              const SizedBox(
                height: 16,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Price'),
                  Text('so luong con lái'),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Description'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                child: const Text('Thêm vào giỏ hàng'),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Mua ngay'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
