import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'common/product_card.dart';

class HomeUser extends StatelessWidget {
  HomeUser({super.key});
  static const route = '/HomeUser';

  final RxInt index = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [header(), body(context)],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 56,
        child: Obx(
          () => SalomonBottomBar(
            currentIndex: index.value,
            onTap: (i) => index.value == i,
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: Icon(Icons.home),
                title: Text("Home"),
                selectedColor: Colors.purple,
              ),

              /// Likes
              SalomonBottomBarItem(
                icon: Icon(Icons.favorite_border),
                title: Text("Likes"),
                selectedColor: Colors.pink,
              ),

              /// Search
              SalomonBottomBarItem(
                icon: Icon(Icons.search),
                title: Text("Search"),
                selectedColor: Colors.orange,
              ),

              /// Profile
              SalomonBottomBarItem(
                icon: Icon(Icons.person),
                title: Text("Profile"),
                selectedColor: Colors.teal,
              ),
            ],
          ),
        ),
      ),
    );
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
              padding: EdgeInsets.symmetric(vertical: 16),
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
