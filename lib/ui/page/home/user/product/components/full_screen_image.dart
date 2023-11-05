import 'package:flutter/material.dart';
import 'package:web_app/constant.dart';
import 'package:web_app/ui/page/home/admin/components/product_manager/product_manager_view.dart';

import '../../../../../../model/network/product_manager_model.dart';

// import '../../../../../../model/network/order_manager_model.dart';

class ImageFullScreenScreen extends StatelessWidget {
  final List<Images>? images;
  final int index;

  const ImageFullScreenScreen(
      {super.key, required this.images, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: PageView.builder(
          itemBuilder: (context, index) {
            return Container(
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ImageComponent(
                        imageUrl: domain + (images?[index].url ?? '')),
                  ),
                ],
              ),
            );
          },
          itemCount: images?.length,
          controller: PageController(initialPage: index),
//         initialPage: index,
        ),
      ),
    );
  }
}
