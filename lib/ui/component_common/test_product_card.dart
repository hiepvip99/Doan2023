import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/ui/component_common/circle_button.dart';

import '../../constant.dart';
import '../../extendsion/extendsion.dart';
import '../../model/network/product_manager_model.dart';
import '../../service/local/save_data.dart';
import '../../service/network/product_service.dart';
import '../page/home/admin/components/product_manager/product_manager_view.dart';
import '../page/home/user/product/product_view.dart';

class TestProductCard extends StatefulWidget {
  // final String imageUrl;
  // final int price;
  final Function()? onRefesh;
  final Function(Favorite favorite, bool isChecked)? onSelected;
  final Product product;
  final bool isShowChecked;
  const TestProductCard({
    super.key,
    // required this.imageUrl,
    // required this.price,
    this.isShowChecked = false,
    this.onRefesh,
    this.onSelected,
    required this.product,
  });

  @override
  State<TestProductCard> createState() => _TestProductCardState();
}

class _TestProductCardState extends State<TestProductCard> {
  ProductService networkService = ProductService();
  bool isChecked = false;
  bool isFavorite = false;
  final accountId = DataLocal.getAccountId();
  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    if (isFavorite) {
      addToFavorite();
    } else {
      removeFavorite();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      networkService
          .checkFavorite(
              Favorite(accountId: accountId, productId: widget.product.id))
          .then((value) {
        isFavorite = value?.isFavorite ?? false;
        setState(() {});
      });
    });
  }

  Future<void> addToFavorite() async {
    networkService.addFavorite(
        Favorite(accountId: accountId, productId: widget.product.id));
    // Get.find<FavoriteViewModel>().getAllFavoriteProduct();
  }

  Future<void> removeFavorite() async {
    await networkService.removeFavorite([
      Favorite(accountId: accountId, productId: widget.product.id)
    ]).then((value) {
      print('status: ${value?.statusCode}');
    });
    // Get.find<FavoriteViewModel>().getAllFavoriteProduct();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onLongPress: () {
      //   setState(() {
      //     isChecked = !isChecked;
      //   });
      // },
      onTap: () {
        // print('object');
        widget.isShowChecked
            ? setState(() {
                isChecked = !isChecked;
              })
            : Get.toNamed(ProductView.route, arguments: widget.product)
                ?.whenComplete(
                    () => widget.onRefesh != null ? widget.onRefesh!() : null);
        if (widget.onSelected != null) {
          widget.onSelected!(Favorite(productId: widget.product.id), isChecked);
        }
        // Get.toNamed(ProductView.route, arguments: widget.product)?.whenComplete(
        //     () => widget.onRefesh != null ? widget.onRefesh!() : null);
        // if (onSelected != null) {
        //   onSelected!(Favorite(productId: product.id), isChecked.value);
        // }
      },
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.isShowChecked
              ? (isChecked ? Colors.lightBlueAccent : Colors.white)
              : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                // height: 200,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(10)),
                      // child: Image.network(
                      //   'https://www.travelandleisure.com/thmb/eKGIFTp7RBsI6GbSv_Jqs3S8kAE=/fit-in/1500x1000/filters:no_upscale():max_bytes(150000):strip_icc()/adidas-womens-cloudfoam-pure-running-shoe-5f4e6602f9444d0f8570ec4c3f949c22.jpg',
                      //   fit: BoxFit.cover,
                      //   width: double.infinity,
                      // ),
                      child: Center(
                        child: ImageComponent(
                          isShowBorder: false,
                          imageUrl: domain +
                              (widget.product.colors
                                      ?.firstWhereOrNull(
                                          (element) => element.images != null)
                                      ?.images
                                      ?.firstWhereOrNull(
                                        (element) => element.url != null,
                                      )
                                      ?.url ??
                                  ''),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: MyCircleButton(
                        padding: const EdgeInsets.all(10),
                        onTap: toggleFavorite,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(90)),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.product.colors?.length != 0
                        ? formatMoney(widget.product.colors?.first.price ?? 0)
                        : '0 đ',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
