import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/constant.dart';
import 'package:web_app/extendsion/extendsion.dart';

import '../../../../../model/network/cart_model.dart';
import '../../admin/components/product_manager/product_manager_view.dart';
import '../cart/cart_view.dart';
import '../search/search_view.dart';
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
  final RxInt indexSizeCkecked = 0.obs;
  final RxInt count = 1.obs;

  ProductInCart product = ProductInCart();

  int getQuantity() {
    return viewModel.product.sizes
            ?.firstWhereOrNull((element) =>
                (element.colorId ==
                    viewModel.product.colors?[indexColorImage.value].colorId) &&
                (element.sizeId ==
                    viewModel.product.sizes?[indexSizeCkecked.value].sizeId))
            ?.quantity ??
        0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              Get.toNamed(ShoppingCartScreen.route);
            },
            icon: const Icon(Icons.shopping_cart))
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
                      Obx(
                        () => CarouselSlider(
                          options: CarouselOptions(
                            onPageChanged: (index, reason) {
                              indexImage.value = index + 1;
                            },
                          ),
                          items: (viewModel.product.colors != null &&
                                  viewModel
                                          .product
                                          .colors![indexColorImage.value]
                                          .images !=
                                      null)
                              ? viewModel.product.colors![indexColorImage.value]
                                  .images!
                                  .map(
                                    (item) => ImageComponent(
                                        isShowBorder: false,
                                        imageUrl: domain + (item.url ?? '')),
                                  )
                                  .toList()
                              : [],
                        ),
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
                  Text(viewModel.product.name ?? ''),
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
              Obx(
                () => Text(
                    'Giá: ${formatMoney(viewModel.product.colors?[indexColorImage.value].price ?? 0)}'),
              ),
              const SizedBox(
                height: 16,
              ),
              Obx(
                () => Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    const Text('Màu sắc:'),
                    if (viewModel.product.colors != null)
                      ...viewModel.product.colors!
                          .map((e) => CustomCheckbox(
                                onChangeCallBack: () {
                                  indexColorImage.value =
                                      viewModel.product.colors!.indexOf(e);
                                  indexImage.value = 1;
                                  setCountProduct();
                                },
                                text: viewModel.colorList.value
                                        .firstWhereOrNull((element) =>
                                            element.id == e.colorId)
                                        ?.name ??
                                    '',
                                isChecked:
                                    viewModel.product.colors?.indexOf(e) ==
                                        indexColorImage.value,
                              ))
                          .toList()
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Obx(
                () => Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    const Text('Size:'),
                    // if (viewModel.sizeOfProduct.value != null)
                    ...viewModel.sizeOfProduct.value
                        .map((e) => CustomCheckbox(
                              onChangeCallBack: () {
                                indexSizeCkecked.value =
                                    viewModel.sizeOfProduct.value.indexOf(e);
                                setCountProduct();
                              },
                              text: viewModel.sizeList.value
                                      .firstWhereOrNull(
                                          (element) => element.id == e)
                                      ?.name ??
                                  '',
                              isChecked:
                                  viewModel.sizeOfProduct.value.indexOf(e) ==
                                      indexSizeCkecked.value,
                            ))
                        .toList()
                  ],
                ),
              ),
              // const Wrap(
              //   children: [
              //     CustomCheckbox(
              //       text: 'test',
              //       isChecked: true,
              //     ),
              //   ],
              // ),
              // Container(color: Colors.purple, child: const Text('chon size')),
              const SizedBox(
                height: 16,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text('Price'),
                  const Text('Số Lượng: '),
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(shape: const CircleBorder()),
                      onPressed: () {
                        if (count.value > 1) {
                          count.value--;
                        }
                      },
                      child: const Text('-')),
                  Obx(() => Text(' ${count.value} ')),
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(shape: const CircleBorder()),
                      onPressed: () {
                        if (count.value < getQuantity()) {
                          count.value++;
                        }
                      },
                      child: const Text('+')),
                  const SizedBox(
                    width: 4,
                  ),
                  Obx(() => Text('Kho: ${getQuantity()}')),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text('${viewModel.product.description}'),
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
                onPressed: () {
                  product.colorId =
                      viewModel.product.colors?[indexColorImage.value].colorId;
                  product.sizeId =
                      viewModel.product.sizes?[indexSizeCkecked.value].sizeId;
                  product.quantity = count.value;
                  viewModel.addToCart(product);
                },
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

  void setCountProduct() {
    if (getQuantity() < 1) {
      count.value = 0;
    } else {
      count.value = 1;
    }
    if (viewModel.product.colors?[indexColorImage.value].images?.length == 0) {
      indexImage.value = 0;
    } else {
      indexImage.value = 1;
    }
  }
}
