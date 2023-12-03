import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:web_app/constant.dart';
import 'package:web_app/extendsion/extendsion.dart';

import '../../../../../model/network/cart_model.dart';
import '../../../../../model/network/order_manager_model.dart';
import '../../../../../model/network/product_manager_model.dart';
import '../../../../component_common/circle_widget.dart';
import '../../admin/components/product_manager/product_manager_view.dart';
import '../cart/cart_view.dart';
import '../search/search_view.dart';
import 'components/checkbox.dart';
import 'components/full_screen_image.dart';
import 'product_view_model.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  static String route = '/ProductView';

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  late ProductViewModel viewModel;

  final RxInt indexColorImage = 0.obs;
  final RxInt indexImage = 1.obs;
  final RxInt indexSizeCkecked = 0.obs;
  final RxInt count = 1.obs;

  ProductInCart product = ProductInCart();

  int getQuantity() {
    return viewModel.product.value.sizes
            ?.firstWhereOrNull((element) =>
                (element.colorId ==
                    viewModel.product.value.colors?[indexColorImage.value]
                        .colorId) &&
                (element.sizeId ==
                    viewModel
                        .product.value.sizes?[indexSizeCkecked.value].sizeId))
            ?.quantity ??
        0;
  }

  static const _pageSize = 10;

  final PagingController<int, Review> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    viewModel = Get.find<ProductViewModel>();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   handleInNotificationClick();
    // });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      // viewModel.currentPage.value = pageKey;
      viewModel.step = _pageSize;
      await viewModel.getAllReview();
      // ignore: invalid_use_of_protected_member
      final newItems = viewModel.reviewList.value;
      /* final newItems = await RemoteApi.getBeerList(pageKey, _pageSize); */
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        viewModel.currentPage.value += 1;
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
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
      body: RefreshIndicator(
        onRefresh: () => viewModel.getProduct(),
        child: Padding(
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
                          () => GestureDetector(
                            onTap: () {
                              Get.to(
                                  () => ImageFullScreenScreen(
                                      images: viewModel
                                          .product
                                          .value
                                          .colors![indexColorImage.value]
                                          .images,
                                      index: indexImage.value - 1),
                                  fullscreenDialog: true);
                            },
                            child: CarouselSlider(
                              options: CarouselOptions(
                                onPageChanged: (index, reason) {
                                  indexImage.value = index + 1;
                                },
                              ),
                              items: (viewModel.product.value.colors != null &&
                                      viewModel
                                              .product
                                              .value
                                              .colors![indexColorImage.value]
                                              .images !=
                                          null)
                                  ? viewModel.product.value
                                      .colors![indexColorImage.value].images!
                                      .map(
                                        (item) => ImageComponent(
                                            isShowBorder: false,
                                            imageUrl:
                                                domain + (item.url ?? '')),
                                      )
                                      .toList()
                                  : [],
                            ),
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
                                  '${indexImage.value} / ${viewModel.product.value.colors?[indexColorImage.value].images?.length ?? 1}')),
                            ),
                          ),
                        )
                      ],
                    )),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      viewModel.product.value.name ?? '',
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
                    'Giá: ${formatMoney(viewModel.product.value.colors?[indexColorImage.value].price ?? 0)}',
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
                      if (viewModel.product.value.colors != null)
                        ...viewModel.product.value.colors!
                            .map((e) => InkWell(
                                  onTap: () {
                                    indexColorImage.value = viewModel
                                        .product.value.colors!
                                        .indexOf(e);
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
                                    child: viewModel.product.value.colors
                                                ?.indexOf(e) ==
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
                                  //       viewModel.product.value.colors?.indexOf(e) ==
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
                                  isSelected: viewModel.sizeOfProduct.value
                                          .indexOf(e) ==
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
                  'Freeship cho đơn hàng từ 500.000 đ',
                  style: TextStyle(fontSize: 16),
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
                  '${viewModel.product.value.description ?? "Chưa có mô tả"}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Đánh giá trung bình về sản phẩm này: ${viewModel.totalRatingS.value == 0 ? 5.0 : viewModel.averageRating.value} / 5.0',
                        style: const TextStyle(fontSize: 16),
                      ),
                      // const SizedBox(height: 16),
                      // const Text(
                      //   'Phân phối Đánh giá:',
                      //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      // ),
                      const SizedBox(height: 16),

                      Text(
                        'Tổng số đánh giá: ${viewModel.totalRatingS.value}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      RatingDistributionBar(
                          totalCount: viewModel.totalRating.value,
                          rating: 5,
                          count: viewModel.ratingCounts.value.star5 ?? 0),
                      RatingDistributionBar(
                          totalCount: viewModel.totalRating.value,
                          rating: 4,
                          count: viewModel.ratingCounts.value.star4 ?? 0),
                      RatingDistributionBar(
                          totalCount: viewModel.totalRating.value,
                          rating: 3,
                          count: viewModel.ratingCounts.value.star3 ?? 0),
                      RatingDistributionBar(
                          totalCount: viewModel.totalRating.value,
                          rating: 2,
                          count: viewModel.ratingCounts.value.star2 ?? 0),
                      RatingDistributionBar(
                          totalCount: viewModel.totalRating.value,
                          rating: 1,
                          count: viewModel.ratingCounts.value.star1 ?? 0),
                      const SizedBox(height: 16),
                      const Text(
                        'Đánh giá nổi bật:',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      PagedListView<int, Review>(
                        pagingController: _pagingController,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        builderDelegate: PagedChildBuilderDelegate<Review>(
                          noMoreItemsIndicatorBuilder: (context) {
                            return const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Image.asset('assets/images/star_shopee.png'),
                                Text('Không còn đánh giá nào!'),
                              ],
                            );
                          },
                          noItemsFoundIndicatorBuilder: (context) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/star_shopee.png'),
                                const Text('Không có đánh giá nào!'),
                              ],
                            );
                          },
                          itemBuilder: (context, item, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          child: ImageComponent(
                                              imageUrl: domain +
                                                  (item.customerImage ?? '')),
                                          // color: Colors.,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.customerName ?? '',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: List.generate(
                                              item.rating?.round() ?? 0,
                                              (index) => const Icon(Icons.star,
                                                  color: Colors.yellow),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            item.reviewText ?? '',
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            formatDate(item.createdAt ??
                                                DateTime(2023)),
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                          // Khoảng cách giữa icon và Text
                                        ],
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.grey.shade300,
                                    thickness: 1,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   itemCount: reviews.length,
                      //   itemBuilder: (context, index) {
                      //     final review = reviews[index];
                      //   },
                      // ),
                    ],
                  ),
                )
              ],
            ),
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
                  product.colorId = viewModel
                      .product.value.colors?[indexColorImage.value].colorId;
                  product.sizeId = viewModel
                      .product.value.sizes?[indexSizeCkecked.value].sizeId;
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
    if (viewModel.product.value.colors?[indexColorImage.value].images?.length ==
        0) {
      indexImage.value = 0;
    } else {
      indexImage.value = 1;
    }
  }
}

class RatingDistributionBar extends StatelessWidget {
  final int rating;
  final int count;
  final int totalCount;

  const RatingDistributionBar({
    super.key,
    required this.rating,
    required this.count,
    required this.totalCount,
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
            value: count / totalCount,
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
