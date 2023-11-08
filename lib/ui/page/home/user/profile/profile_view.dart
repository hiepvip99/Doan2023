import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/ui/page/home/admin/components/product_manager/product_manager_view.dart';
import 'package:web_app/ui/page/home/user/profile/my_profile/my_profile_view_model.dart';
import 'package:web_app/ui/page/login/login_controller.dart';

import '../../../../../constant.dart';
import '../../../../component_common/circle_button.dart';
import '../about_us/about_us.dart';
import '../cart/cart_view.dart';
import '../discount/discount_view.dart';
import '../my_order_manager/my_order_view.dart';
import '../my_review/my_review.dart';
import 'my_profile/my_profile_view.dart';
import 'profile_view_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final viewModel = Get.find<ProfileViewModel>();

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
                child: Obx(
                  () => ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: ImageComponent(
                        isShowBorder: false,
                        imageUrl: domain +
                            (viewModel.customerInfo.value.image ?? '')),
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Obx(
                  () => Text(viewModel.customerInfo.value.name ?? '',
                      overflow: TextOverflow.ellipsis),
                ),
              )),
              MyCircleButton(
                  padding: const EdgeInsets.all(8),
                  onTap: () {
                    Get.toNamed(EditProfileScreen.route,
                        arguments:
                            ProfileArg(customer: viewModel.customerInfo.value));
                  },
                  child: const Icon(Icons.mode_edit_outline_sharp))
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
          ItemProfile(
            showBottomDivider: true,
            title: 'Đánh giá của tôi',
            onTap: () {
              Get.toNamed(MyReview.route,
                  arguments: viewModel.customerInfo.value);
            },
          ),
          const ItemProfile(
              showBottomDivider: true,
              title: 'Mã giảm giá',
              route: DiscountCodeView.route),
          const ItemProfile(
              showBottomDivider: true,
              title: 'Về chúng tôi',
              route: AboutUs.route),
          ItemProfile(
            showBottomDivider: true,
            title: 'Đăng xuất',
            onTap: () => LoginController().logoutApp(),
          ),
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
      this.route,
      this.onTap});

  final bool showBottomDivider;
  final String title;

  final String? route;
  final Function()? onTap;

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
        onTap: () {
          route != null ? Get.toNamed(route!) : null;
          onTap != null ? onTap!() : null;
        },
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
