import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:web_app/model/network/product_manager_model.dart';
import 'package:web_app/ui/page/home/admin/components/product_manager/product_manager_view.dart';
import 'package:web_app/ui/page/home/user/cart/cart_view.dart';
import 'package:web_app/ui/page/home/user/favorite/favorite_view.dart';
import 'package:web_app/ui/page/home/user/home_user_controller.dart';
import 'package:web_app/ui/page/home/user/search/search_view.dart';

import '../../../../constant.dart';
import '../../../component_common/test_product_card.dart';
import 'common/product_card.dart';
import 'notification/notification_view.dart';
import 'profile/profile_view.dart';

// ignore: must_be_immutable
class HomeUser extends StatefulWidget {
  const HomeUser({super.key});
  static const route = '/HomeUser';

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  static const _pageSize = 10;
  final viewModel = Get.find<HomeUserController>();

  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleInNotificationClick();
    });
  }

  void handleInNotificationClick() {
    final indexArg = Get.arguments;
    if (indexArg is int) {
      viewModel.changeIndex();
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      viewModel.currentPage.value = pageKey;
      viewModel.selectedItem.value = _pageSize.toString();
      await viewModel.getAllProduct();
      final newItems = viewModel.productList;
      /* final newItems = await RemoteApi.getBeerList(pageKey, _pageSize); */
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() => getBody(context, viewModel.index.value)),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 56,
        child: Obx(
          () => BottomNavigationBar(
              currentIndex: viewModel.index.value,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black26,
              type: BottomNavigationBarType.fixed,
              onTap: (value) => viewModel.index.value = value,
              items: const [
                BottomNavigationBarItem(
                    label: 'Trang chủ',
                    icon: FaIcon(
                      FontAwesomeIcons.house,
                      size: 20,
                    )),
                BottomNavigationBarItem(
                    label: 'Đã thích', icon: FaIcon(FontAwesomeIcons.heart)),
                BottomNavigationBarItem(
                    label: 'Thông báo', icon: FaIcon(FontAwesomeIcons.bell)),
                BottomNavigationBarItem(
                    label: 'Tôi', icon: FaIcon(FontAwesomeIcons.user)),
              ]),
          // () => SalomonBottomBar(
          //   currentIndex: viewModel.index.value,
          //   onTap: (i) {
          //     viewModel.index.value = i;
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
        return const FavoriteView();
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
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              // color: Colors.amber,
              child: const ImageComponent(
                  imageUrl: domain + 'api/image/banner.png'),
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
            Obx(
              () => SizedBox(
                height: 36,
                child: ListView.builder(
                  // padding: const EdgeInsets.only(left: 8),
                  scrollDirection: Axis.horizontal,
                  itemCount: viewModel.manufacturerList.value.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Get.toNamed(SearchView.route,
                          arguments: viewModel.manufacturerList.value[index]);
                      print(viewModel.manufacturerList.value[index].id);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: GestureDetector(
                        child: Text(
                          '${viewModel.manufacturerList.value[index].name}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // const SizedBox(
            //   height: 16,
            // ),
            // Container(
            //   height: 30,
            //   color: Colors.black45,
            //   child: ListView.builder(
            //     // ignore: invalid_use_of_protected_member
            //     itemCount: viewModel.manufacturerList.value.length,
            //     itemBuilder: (context, viewModel.index) => OutlinedButton(
            //         onPressed: () {
            //           // xu ly goi get list by manufacturer va chuyen sang trang tim kiem or hien thi san pham
            //           // viewModel.keyword = ''
            //           // viewModel.getAllProduct();
            //         },
            //         child: Text(
            //             viewModel.manufacturerList.value[viewModel.index].name ?? '')),
            //   ),
            // ),
            // const SizedBox(
            //   height: 16,
            // ),
            PagedGridView<int, Product>(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 16),
              physics: const NeverScrollableScrollPhysics(),
              pagingController: _pagingController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 3 / 4,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              builderDelegate: PagedChildBuilderDelegate<Product>(
                itemBuilder: (context, item, index) => TestProductCard(
                  // beer: item,
                  product: item,
                ),
              ),
            ),
            // GridView.builder(
            //   padding: const EdgeInsets.symmetric(vertical: 16),
            //   shrinkWrap: true,
            //   itemCount: 8,
            //   physics: const NeverScrollableScrollPhysics(),
            //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            //       crossAxisSpacing: 10,
            //       mainAxisSpacing: 10,
            //       maxCrossAxisExtent: 175,
            //       childAspectRatio: 0.75),
            //   itemBuilder: (context, viewModel.index) => ProductCard(),
            // ),
          ],
        ),
      );

  Widget header() => Padding(
        padding: const EdgeInsets.all(8),
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
              onTap: () {
                Get.toNamed(ShoppingCartScreen.route);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.shopping_cart),
              ),
            )
          ],
        ),
      );
}
