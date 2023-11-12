import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/ui/page/home/user/notification/component/notification_widget.dart';
import 'package:web_app/ui/page/home/user/product/product_view.dart';

import '../../../../component_common/test_product_card.dart';
import 'notification_view_model.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  static const route = '/NotificationView';

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final viewModel = Get.find<NotificationViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông báo'),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
            // shrinkWrap: ,
            padding: const EdgeInsets.only(top: 4),
            itemCount: viewModel.notificationList.value.length,
            itemBuilder: (context, index) => NotificationWidget(
                title: viewModel.notificationList.value[index].title ?? '',
                message: viewModel.notificationList.value[index].content ?? ''),
          )),
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
