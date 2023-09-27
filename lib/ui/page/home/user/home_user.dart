import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/ui/page/home/user/favorite/favorite_view.dart';
import 'package:web_app/ui/page/home/user/search/search_view.dart';

import 'common/product_card.dart';
import 'notification/notification_view.dart';
import 'profile/profile.dart';

// ignore: must_be_immutable
class HomeUser extends StatelessWidget {
  HomeUser({super.key});
  static const route = '/HomeUser';

  RxInt index = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() => getBody(context, index.value)),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 56,
        child: Obx(
          () => BottomNavigationBar(
              currentIndex: index.value,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black26,
              type: BottomNavigationBarType.fixed,
              onTap: (value) => index.value = value,
              items: const [
                BottomNavigationBarItem(
                    label: 'Trang chủ', icon: Icon(Icons.home_filled)),
                BottomNavigationBarItem(
                    label: 'Đã thích', icon: Icon(Icons.favorite_border)),
                BottomNavigationBarItem(
                    label: 'Thông báo', icon: Icon(Icons.notifications_none)),
                BottomNavigationBarItem(
                    label: 'Tôi', icon: Icon(Icons.person_pin_outlined)),
              ]),
          // () => SalomonBottomBar(
          //   currentIndex: index.value,
          //   onTap: (i) {
          //     index.value = i;
          //   },
          //   items: [
          //     /// Home
          //     SalomonBottomBarItem(
          //       icon: const Icon(Icons.home_filled),
          //       title: const Text("Home"),
          //       selectedColor: Colors.black,
          //     ),

          //     /// Likes
          //     SalomonBottomBarItem(
          //       icon: const Icon(Icons.favorite_border),
          //       title: const Text("Likes"),
          //       selectedColor: Colors.black,
          //     ),

          //     /// Search
          //     SalomonBottomBarItem(
          //       icon: const Icon(Icons.notifications_none),
          //       title: const Text("Notification"),
          //       selectedColor: Colors.black,
          //     ),

          //     /// Profile
          //     SalomonBottomBarItem(
          //       icon: const Icon(Icons.person_outline),
          //       title: const Text("Profile"),
          //       selectedColor: Colors.black,
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }

  Widget getBody(BuildContext context, int indexs) {
    switch (indexs) {
      case 0:
        return Column(
          children: [header(), body(context)],
        );
      case 1:
        return FavoriteView();
      case 2:
        return const NotificationView();
      case 3:
        return const ProfileView();
      default:
        return Column(
          children: [header(), body(context)],
        );
    }
  }

  Widget body(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              color: Colors.amber,
              child: const Text('banner sale'),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Danh mục giày',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 30,
              color: Colors.black45,
              child: const Text('Danh sách danh mục giày'),
            ),
            GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
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
      );

  Widget header() => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => Get.toNamed(SearchView.route),
                child: Container(
                  height: 36,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle, color: Colors.grey.shade200),
                  child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.search),
                      )),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.shopping_cart),
              ),
            )
          ],
        ),
      );
}
