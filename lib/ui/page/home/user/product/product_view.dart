import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'product_view_model.dart';

class ProductView extends StatelessWidget {
  ProductView({super.key});
  static String route = '/ProductView';
  final viewModel = Get.find<ProductViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart))
      ]),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.orange,
                height: 300,
                child: Text('Image profduct'),
              ),
              SizedBox(
                height: 16,
              ),
              Container(color: Colors.amber, child: Text('Danh sasch anh')),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Product name'),
                  GestureDetector(
                    onTap: () =>
                        viewModel.favorite.value = !viewModel.favorite.value,
                    child: Obx(
                      () => Icon(
                        viewModel.favorite.value
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: viewModel.favorite.value
                            ? Colors.red
                            : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Text('Nhaf san xuat : Nike'),
              SizedBox(
                height: 16,
              ),
              Container(color: Colors.blue, child: Text('chon mau')),
              SizedBox(
                height: 16,
              ),
              Container(color: Colors.purple, child: Text('chon size')),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Price'),
                  Text('so luong con lái'),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Text('Description'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                child: Text('Thêm vào giỏ hàng'),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Mua ngay'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
