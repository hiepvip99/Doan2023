import 'package:flutter/material.dart';

class ProductReviewPage extends StatefulWidget {
  const ProductReviewPage({super.key});

  static const route = '/ProductReviewPage';

  @override
  State<ProductReviewPage> createState() => _ProductReviewPageState();
}

class _ProductReviewPageState extends State<ProductReviewPage> {
  String _reviewText = '';
  double _rating = 0.0;

  void _submitReview() {
    // Gửi đánh giá sản phẩm đi và xử lý dữ liệu ở đây
    print('Đánh giá: $_reviewText');
    print('Điểm đánh giá: $_rating');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đánh giá sản phẩm'),
      ),
      body: Padding(
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
              maxLines: 4,
              onChanged: (value) {
                setState(() {
                  _reviewText = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitReview,
              child: const Text('Gửi đánh giá'),
            ),
          ],
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
    return Row(
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
    );
  }
}
