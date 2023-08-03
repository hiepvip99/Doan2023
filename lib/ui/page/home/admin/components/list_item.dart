// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../home_admin_controller.dart';

class LeftMenu extends StatelessWidget {
  LeftMenu({super.key, required this.controller});

  final List<ItemMenu> menuList = [
    ItemMenu(
      title: 'Quản lý tài khoản',
    ),
    ItemMenu(
      title: 'Quản lý nhà sản xuất',
    ),
    ItemMenu(
      title: 'Quản lý sản phẩm',
    ),
    ItemMenu(
      title: 'Quản lý đơn hàng',
    ),
    ItemMenu(
      title: 'Thống kê',
    ),
    ItemMenu(
      title: 'Chương trình ưu đãi',
    ),
    ItemMenu(
      title: 'Khách hàng thân thiết',
    ),
    ItemMenu(
      title: 'Cài đặt',
    ),
    ItemMenu(
      title: 'Đăng xuất',
    ),
  ];

  final HomeAdminController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.grey))),
      constraints: const BoxConstraints(maxWidth: 300),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shoe store',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 50,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: menuList.length - 2,
                itemBuilder: (context, index) => Obx(
                  () => GestureDetector(
                    onTap: () => {controller.indexSelected.value = index},
                    child: Container(
                      color: controller.indexSelected.value == index
                          ? Colors.blue.shade100
                          : Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            menuList[index].title,
                            style: TextStyle(
                                color: controller.indexSelected.value == index
                                    ? Colors.black
                                    : Colors.grey,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
                  // thickness: 1,
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              ...List.generate(
                2,
                (index) => GestureDetector(
                  onTap: () => {
                    controller.indexSelected.value =
                        index + (menuList.length - 2)
                  },
                  child: Obx(
                    () => Container(
                      color: controller.indexSelected.value ==
                              (index + (menuList.length - 2))
                          ? Colors.blue.shade100
                          : Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            menuList[index + (menuList.length - 2)].title,
                            style: TextStyle(
                                color: controller.indexSelected.value ==
                                        index + (menuList.length - 2)
                                    ? Colors.black
                                    : Colors.grey,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemMenu {
  String title;
  ItemMenu({
    required this.title,
  });
}
