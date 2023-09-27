import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/product_card.dart';
import 'favorite_view_model.dart';

class FavoriteView extends StatelessWidget {
  FavoriteView({super.key});

  static String route = '/FavoriteView';

  final viewModel = Get.find<FavoriteViewModel>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GridView.builder(
              // padding: const EdgeInsets.symmetric(vertical: 16),
              shrinkWrap: true,
              itemCount: 8,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  maxCrossAxisExtent: 175,
                  childAspectRatio: 0.75),
              itemBuilder: (context, index) => ProductCard(),
            )
          ],
        ),
      ),
    );
  }
}
