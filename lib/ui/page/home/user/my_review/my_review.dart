import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../constant.dart';
import '../../../../../extendsion/extendsion.dart';
import '../../../../../model/network/order_manager_model.dart';
import '../../admin/components/product_manager/product_manager_view.dart';
import 'my_review_view_model.dart';

class MyReview extends StatefulWidget {
  const MyReview({super.key});

  static const route = '/MyReview';

  @override
  State<MyReview> createState() => _MyReviewState();
}

class _MyReviewState extends State<MyReview> {
  final viewModel = Get.find<MyReviewViewModel>();

  static const _pageSize = 10;

  final PagingController<int, Review> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      // viewModel.currentPage.value = pageKey;
      viewModel.step = _pageSize;
      await viewModel.getMyReview();
      // ignore: invalid_use_of_protected_member
      final newItems = viewModel.reviewList.value;
      /* final newItems = await RemoteApi.getBeerList(pageKey, _pageSize); */
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        viewModel.currentPage.value += 1;
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
        title: const Text('Đánh giá của tôi'),
        centerTitle: true,
      ),
      body: PagedListView<int, Review>(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        pagingController: _pagingController,
        // shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        builderDelegate: PagedChildBuilderDelegate<Review>(
          noMoreItemsIndicatorBuilder: (context) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Không còn đánh giá nào!'),
              ],
            );
          },
          noItemsFoundIndicatorBuilder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/star_shopee.png'),
                const Text('Bạn chưa có đánh giá nào!'),
              ],
            );
          },
          itemBuilder: (context, item, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: ImageComponent(
                              imageUrl: domain + (item.customerImage ?? '')),
                          // color: Colors.,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            item.customerName ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              item.rating?.round() ?? 0,
                              (index) =>
                                  const Icon(Icons.star, color: Colors.yellow),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item.reviewText ?? '',
                          ),
                          const SizedBox(height: 8),
                          Text(
                            formatDateTime(item.createdAt ?? DateTime(2023)),
                            style: const TextStyle(color: Colors.grey),
                          ),
                          // Khoảng cách giữa icon và Text
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                    thickness: 1,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
