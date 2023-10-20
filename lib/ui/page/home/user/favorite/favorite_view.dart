import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:web_app/model/network/product_manager_model.dart';

import '../common/product_card.dart';
import 'favorite_view_model.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  static String route = '/FavoriteView';

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  final viewModel = Get.find<FavoriteViewModel>();
  final RxBool isEdit = false.obs;
  static const _pageSize = 10;

  List<Favorite> favoriteSeleted = [];

  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      viewModel.currentPage.value = pageKey;
      viewModel.selectedItem.value = _pageSize.toString();
      await viewModel.getAllFavoriteProduct();
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
      appBar: AppBar(
        title: const Text('Sản phẩm đã thích'),
        centerTitle: true,
        actions: [
          OutlinedButton(
              onPressed: () {
                isEdit.value = !isEdit.value;
              },
              child: Obx(() => Text(
                    isEdit.value ? 'Huỷ' : 'Sửa',
                  )))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => SizedBox(
                height: isEdit.value
                    ? MediaQuery.of(context).size.height - 174
                    : MediaQuery.of(context).size.height - 126,
                child: PagedGridView<int, Product>(
                  // shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  // physics: const NeverScrollableScrollPhysics(),
                  pagingController: _pagingController,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      maxCrossAxisExtent: 175,
                      childAspectRatio: 0.75),
                  builderDelegate: PagedChildBuilderDelegate<Product>(
                    itemBuilder: (context, item, index) => GestureDetector(
                      // onTap: () {},
                      child: Obx(
                        () => ProductCard(
                          onRefesh: () => _pagingController.refresh(),
                          // isChecked: ,
                          onSelected: (favorite, isChecked) {
                            if (isChecked) {
                              favoriteSeleted.addIf(
                                  !favoriteSeleted.any((element) =>
                                      favorite.productId == element.productId),
                                  favorite);
                            } else {
                              favoriteSeleted.removeWhere((element) =>
                                  favorite.productId == element.productId);
                            }
                            print(favoriteSeleted.length);
                          },
                          isShowChecked: isEdit.value,
                          // beer: item,
                          product: item,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () => Visibility(
                  visible: isEdit.value && viewModel.productList.isNotEmpty,
                  child: ElevatedButton(
                      onPressed: () {
                        viewModel
                            .removeFavorite(favoriteSeleted)
                            .then((value) => _pagingController.refresh());
                        // favoriteSeleted.clear();
                      },
                      child: const Text('Bỏ thích'))),
            ),
          ],
        ),
      ),
    );
  }
}
