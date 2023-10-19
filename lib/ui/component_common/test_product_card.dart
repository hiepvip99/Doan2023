import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/ui/component_common/circle_button.dart';

import '../../extendsion/extendsion.dart';
import '../../model/network/product_manager_model.dart';
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
  bool isChecked = false;
  bool isFavorite = false;
  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      onTap: () {
        print('object');
        Get.toNamed(ProductView.route, arguments: widget.product)?.whenComplete(
            () => widget.onRefesh != null ? widget.onRefesh!() : null);
        // if (onSelected != null) {
        //   onSelected!(Favorite(productId: product.id), isChecked.value);
        // }
      },
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isChecked ? Colors.lightBlueAccent : Colors.white,
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
                      child: Image.network(
                        'https://www.travelandleisure.com/thmb/eKGIFTp7RBsI6GbSv_Jqs3S8kAE=/fit-in/1500x1000/filters:no_upscale():max_bytes(150000):strip_icc()/adidas-womens-cloudfoam-pure-running-shoe-5f4e6602f9444d0f8570ec4c3f949c22.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: MyCircleButton(
                        padding: const EdgeInsets.all(10),
                        onTap: toggleFavorite,
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : null,
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
