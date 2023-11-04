import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/constant.dart';
import 'package:web_app/extendsion/extendsion.dart';

import '../../../../../model/network/cart_model.dart';
import '../../../../../model/network/order_manager_model.dart';
import '../../../../component_common/circle_widget.dart';
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

  final double averageRating = 4.5;
  final int totalReviews = 100;
  final List<Review> reviews = [
    Review(rating: 5, customerName: 'John Doe'),
    Review(rating: 4, customerName: 'Jane Smith'),
    Review(rating: 3, customerName: 'Bob Johnson'),
    // ... more reviews
  ];

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
                  Text(
                    viewModel.product.name ?? '',
                    style: const TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      viewModel.favorite.value = !viewModel.favorite.value;
                      if (viewModel.favorite.value) {
                        viewModel.addToFavorite();
                      } else {
                        viewModel.removeFavorite();
                      }
                    },
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
                  'Giá: ${formatMoney(viewModel.product.colors?[indexColorImage.value].price ?? 0)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Màu sắc:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 16,
              ),
              Obx(
                () => Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (viewModel.product.colors != null)
                      ...viewModel.product.colors!
                          .map((e) => InkWell(
                                onTap: () {
                                  indexColorImage.value =
                                      viewModel.product.colors!.indexOf(e);
                                  indexImage.value = 1;
                                  setCountProduct();
                                },
                                child: Container(
                                  width: 34,
                                  height: 34,
                                  decoration: BoxDecoration(
                                    color: Color(int.parse(
                                            viewModel.colorList.value
                                                    .firstWhereOrNull(
                                                        (element) =>
                                                            element.id ==
                                                            e.colorId)
                                                    ?.colorCode ??
                                                'FFFFFF',
                                            radix: 16) +
                                        0xFF000000),
                                    borderRadius: BorderRadius.circular(4.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 3.0,
                                        offset: const Offset(0, 2),
                                      )
                                    ],
                                  ),
                                  child: viewModel.product.colors?.indexOf(e) ==
                                          indexColorImage.value
                                      ? Icon(
                                          Icons.check,
                                          color: isColorBright(
                                            Color(int.parse(
                                                    viewModel.colorList.value
                                                            .firstWhereOrNull(
                                                                (element) =>
                                                                    element
                                                                        .id ==
                                                                    e.colorId)
                                                            ?.colorCode ??
                                                        'FFFFFF',
                                                    radix: 16) +
                                                0xFF000000),
                                          )
                                              ? Colors.black
                                              : Colors.white,
                                          size: 18.0,
                                        )
                                      : null,
                                ),
                                // child: CircleNumberWidget(
                                //   text: viewModel.colorList.value
                                //           .firstWhereOrNull((element) =>
                                //               element.id == e.colorId)
                                //           ?.name ??
                                //       '',
                                //   isSelected:
                                //       viewModel.product.colors?.indexOf(e) ==
                                //           indexColorImage.value,
                                // ),
                              ))
                          .toList()
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Size:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 16,
              ),
              Obx(
                () => Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    // if (viewModel.sizeOfProduct.value != null)
                    ...viewModel.sizeOfProduct.value
                        .map((e) => InkWell(
                              onTap: () {
                                indexSizeCkecked.value =
                                    viewModel.sizeOfProduct.value.indexOf(e);
                                setCountProduct();
                              },
                              child: CircleNumberWidget(
                                text: viewModel.sizeList.value
                                        .firstWhereOrNull(
                                            (element) => element.id == e)
                                        ?.name ??
                                    '',
                                isSelected:
                                    viewModel.sizeOfProduct.value.indexOf(e) ==
                                        indexSizeCkecked.value,
                              ),
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
                  const Text(
                    'Số Lượng: ',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: 34.0,
                    height: 34.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        if (count.value > 1) {
                          count.value--;
                        }
                      },
                      child: const Icon(
                        Icons.remove,
                        size: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Obx(() => Text(
                        ' ${count.value} ',
                        style: const TextStyle(fontSize: 16),
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: 34.0,
                    height: 34.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        if (count.value < getQuantity()) {
                          count.value++;
                        }
                      },
                      child: const Icon(
                        Icons.add,
                        size: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Obx(() => Text(
                        'Kho: ${getQuantity()}',
                        style: const TextStyle(fontSize: 16),
                      )),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Mô tả: ',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                '${viewModel.product.description}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Đánh giá trung bình về sản phẩm này: $averageRating/5',
                    style: const TextStyle(fontSize: 16),
                  ),
                  // const SizedBox(height: 16),
                  // const Text(
                  //   'Phân phối Đánh giá:',
                  //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  // ),
                  const SizedBox(height: 16),

                  Text(
                    'Tổng số đánh giá: $totalReviews',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),

                  const RatingDistributionBar(rating: 5, count: 50),
                  const RatingDistributionBar(rating: 4, count: 30),
                  const RatingDistributionBar(rating: 3, count: 10),
                  const RatingDistributionBar(rating: 2, count: 5),
                  const RatingDistributionBar(rating: 1, count: 5),
                  const SizedBox(height: 16),
                  const Text(
                    'Đánh giá:',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(
                                review.rating?.round() ?? 0,
                                (index) => const Icon(Icons.star,
                                    color: Colors.yellow),
                              ),
                            ),
                            const SizedBox(
                                width: 8), // Khoảng cách giữa icon và Text
                            Expanded(
                              child: Text(
                                review.customerName ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
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
            // const SizedBox(
            //   width: 16,
            // ),
            // Expanded(
            //   child: ElevatedButton(
            //     onPressed: () {},
            //     child: const Text('Mua ngay'),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  bool isColorBright(Color color) {
    final brightness = color.computeLuminance();
    return brightness > 0.5; // Ngưỡng 0.5 để phân biệt màu sáng và màu tối
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


class RatingDistributionBar extends StatelessWidget {
  final int rating;
  final int count;

  const RatingDistributionBar({
    super.key,
    required this.rating,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$rating'),
        const SizedBox(width: 8),
        const Icon(Icons.star, color: Colors.yellow),
        const SizedBox(width: 8),
        Expanded(
          child: LinearProgressIndicator(
            value: count / 100,
            color: Colors.blue,
            backgroundColor: Colors.blue.shade50,
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 44,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('$count'),
            ],
          ),
        ),
      ],
    );
  }
}
