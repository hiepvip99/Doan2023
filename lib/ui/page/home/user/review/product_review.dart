import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/service/network/order_service.dart';

import '../../../../../constant.dart';
import '../../../../../model/network/order_manager_model.dart';
import '../../admin/components/product_manager/product_manager_view.dart';
import 'product_review_view_model.dart';

class ProductReviewPage extends StatefulWidget {
  const ProductReviewPage({super.key, this.itemDetail});

  static const route = '/ProductReviewPage';
  final Details? itemDetail;

  @override
  State<ProductReviewPage> createState() => _ProductReviewPageState();
}

class _ProductReviewPageState extends State<ProductReviewPage> {
  String _reviewText = '';
  double _rating = 0;
  final viewModel = Get.find<ProductReviewModel>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Đánh giá sản phẩm'),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom, // Đẩy giao diện lên khi bàn phím xuất hiện
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Đánh giá sản phẩm',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: ImageComponent(
                            isShowBorder: false,
                            imageUrl: domain +
                                (widget.itemDetail?.color?.images?.length != 0
                                    ? widget.itemDetail?.color?.images?.first
                                            .url ??
                                        ''
                                    : '')),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        widget.itemDetail?.product?.name ?? '',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  RatingBar(
                    onRatingChanged: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Nhận xét của bạn',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    maxLines: 7,
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.lightBlueAccent),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _reviewText = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_rating == 0) {
                            Get.showSnackbar(const GetSnackBar(
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.black,
                              message: 'Vui lòng chọn số sao cho sản phẩm',
                              title: 'Bạn chưa hoàn thành đánh giá sản phẩm',
                              duration: Duration(seconds: 2),
                            ));
                            return;
                          }
                          if (_reviewText.trim().isEmpty) {
                            Get.showSnackbar(const GetSnackBar(
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.black,
                              message: 'Vui lòng thêm 1 vài nhận xét',
                              title: 'Bạn chưa hoàn thành đánh giá sản phẩm',
                              duration: Duration(seconds: 2),
                            ));
                            return;
                          }
                          final review = Review(
                              productId: widget.itemDetail?.product?.id,
                              customerId: viewModel.customer.id,
                              orderDetailId: widget.itemDetail?.id,
                              rating: _rating,
                              reviewText: _reviewText);

                          viewModel.submitReview(review);
                        },
                        child: const Text('Gửi đánh giá'),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () => Get.back(),
                        child: const Text('Huỷ bỏ'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RatingBar extends StatefulWidget {
  final Function(double) onRatingChanged;

  const RatingBar({super.key, required this.onRatingChanged});

  @override
  State<RatingBar> createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  double _rating = 0.0;

  void _updateRating(double newRating) {
    setState(() {
      _rating = newRating;
    });
    widget.onRatingChanged(newRating);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(iconTheme: const IconThemeData(color: Colors.orange)),
      child: Row(
        children: [
          IconButton(
            icon: Icon(_rating >= 1 ? Icons.star : Icons.star_border),
            onPressed: () => _updateRating(1),
          ),
          IconButton(
            icon: Icon(_rating >= 2 ? Icons.star : Icons.star_border),
            onPressed: () => _updateRating(2),
          ),
          IconButton(
            icon: Icon(_rating >= 3 ? Icons.star : Icons.star_border),
            onPressed: () => _updateRating(3),
          ),
          IconButton(
            icon: Icon(_rating >= 4 ? Icons.star : Icons.star_border),
            onPressed: () => _updateRating(4),
          ),
          IconButton(
            icon: Icon(_rating >= 5 ? Icons.star : Icons.star_border),
            onPressed: () => _updateRating(5),
          ),
        ],
      ),
    );
  }
}
