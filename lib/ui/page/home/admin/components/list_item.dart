// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_admin_controller.dart';
import 'togee_button.dart';

class LeftMenu extends StatelessWidget {
  final Function() onCloseOrOpenDrawer;
  LeftMenu({
    super.key,
    required this.controller,
    required this.onCloseOrOpenDrawer,
  });

  final List<ItemMenu> menuList = [
    ItemMenu(
      icon: Icons.manage_accounts,
      title: 'Quản lý tài khoản',
    ),
    ItemMenu(
      icon: Icons.precision_manufacturing,
      title: 'Quản lý nhà sản xuất',
    ),
    ItemMenu(
      icon: Icons.category,
      title: 'Quản lý danh mục',
    ),
    ItemMenu(
      icon: Icons.inventory,
      title: 'Quản lý sản phẩm',
    ),
    ItemMenu(
      icon: Icons.description,
      title: 'Quản lý đơn hàng',
    ),
    ItemMenu(
      icon: Icons.show_chart,
      title: 'Thống kê',
    ),
    ItemMenu(
      icon: Icons.loyalty,
      title: 'Chương trình ưu đãi',
    ),
    ItemMenu(
      icon: Icons.groups,
      title: 'Khách hàng thân thiết',
    ),
    ItemMenu(
      icon: Icons.settings,
      title: 'Cài đặt',
    ),
    // ItemMenu(
    //   icon: Icons.logout,
    //   title: 'Đăng xuất',
    // ),
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
            crossAxisAlignment: CrossAxisAlignment.center,
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
                itemCount: menuList.length - 1,
                itemBuilder: (context, index) => Obx(
                  () => GestureDetector(
                    onTap: () => {
                      controller.indexSelected.value = index,
                    },
                    child: Container(
                      color: controller.indexSelected.value == index
                          ? Colors.blue.shade100
                          : Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(menuList[index].icon),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Tooltip(
                              message: menuList[index].title,
                              waitDuration: const Duration(seconds: 1),
                              child: Text(
                                menuList[index].title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color:
                                        controller.indexSelected.value == index
                                            ? Colors.black
                                            : Colors.grey,
                                    fontSize: 16),
                              ),
                            ),
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
              const Divider(
                // thickness: 1,
                height: 1,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 36,
              ),
              ...List.generate(
                1,
                (index) => GestureDetector(
                  onTap: () => {
                    controller.indexSelected.value =
                        index + (menuList.length - 1)
                  },
                  child: Obx(
                    () => Container(
                      color: controller.indexSelected.value ==
                              (index + (menuList.length - 1))
                          ? Colors.blue.shade100
                          : Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(menuList[index + (menuList.length - 1)].icon),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Tooltip(
                              message:
                                  menuList[index + (menuList.length - 1)].title,
                              waitDuration: const Duration(seconds: 1),
                              child: Text(
                                menuList[index + (menuList.length - 1)].title,
                                style: TextStyle(
                                    color: controller.indexSelected.value ==
                                            index + (menuList.length - 1)
                                        ? Colors.black
                                        : Colors.grey,
                                    fontSize: 16),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              DrawerToggleButton(callBack: () {
                onCloseOrOpenDrawer();
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemMenu {
  String title;
  IconData icon;
  ItemMenu({
    required this.title,
    required this.icon,
  });
}
