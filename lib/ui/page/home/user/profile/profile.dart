import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../about_us/about_us.dart';
import '../cart/cart_view.dart';
import '../my_order/my_order_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black54,
                ),
              ),
              const Expanded(
                  child: Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text('full name', overflow: TextOverflow.ellipsis),
              )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.mode_edit_outline_sharp))
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const ItemProfile(
              showBottomDivider: true,
              title: 'Đơn mua',
              route: MyOrderView.route),
          // const ItemProfile(showBottomDivider: true, title: 'Địa chỉ của tôi'),
          const ItemProfile(showBottomDivider: true, title: 'Đánh giá của tôi'),
          const ItemProfile(showBottomDivider: true, title: 'Mã giảm giá'),
          const ItemProfile(
              showBottomDivider: true,
              title: 'Về chúng tôi',
              route: AboutUs.route),
          // TextButton(onPressed: () {}, child: const Text('chỉnh sửa'))
        ],
      ),
    );
  }
}

class ItemProfile extends StatelessWidget {
  const ItemProfile(
      {super.key,
      required this.showBottomDivider,
      required this.title,
      this.route});

  final bool showBottomDivider;
  final String title;

  final String? route;

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   border: Border(
      //       bottom: showBottomDivider
      //           ? BorderSide(width: 1, color: Colors.grey.shade200)
      //           : BorderSide.none),
      // ),
      child: InkWell(
        onTap: () => route != null ? Get.toNamed(route!) : null,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(title), const Icon(Icons.keyboard_arrow_right)],
              ),
              const Divider(
                thickness: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
