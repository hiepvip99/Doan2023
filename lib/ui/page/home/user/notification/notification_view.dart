import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/ui/page/home/user/product/product_view.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  static const route = '/NotificationView';

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          ItemNotification(
              content: 'sale san pham giay',
              image: 'image',
              typeItemNotification: TypeItemNotification.sale),
          ItemNotification(
              content: 'sale san pham giay',
              image: 'image',
              typeItemNotification: TypeItemNotification.sale),
          ItemNotification(
              content: 'sale san pham giay',
              image: 'image',
              typeItemNotification: TypeItemNotification.sale),
          ItemNotification(
              content: 'sale san pham giay',
              image: 'image',
              typeItemNotification: TypeItemNotification.order),
        ],
      ),
    );
  }
}

class ItemNotification extends StatelessWidget {
  const ItemNotification(
      {super.key,
      required this.content,
      required this.image,
      required this.typeItemNotification});

  final String content;
  final String image;
  final TypeItemNotification typeItemNotification;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => typeItemNotification == TypeItemNotification.sale
            ? Get.toNamed(ProductView.route)
            : null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 36,
                width: 36,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.deepOrange),
                child: Text(image),
              ),
              const SizedBox(
                width: 16,
              ),
              Text(content)
            ],
          ),
        ),
      ),
    );
  }
}

enum TypeItemNotification { order, sale }
