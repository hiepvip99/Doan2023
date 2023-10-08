import 'package:flutter/material.dart';
import 'package:tab_container/tab_container.dart';
import 'package:web_app/ui/page/home/admin/components/category_manager/category_view.dart';
import 'package:web_app/ui/page/home/admin/components/color_manager/color_manager_view.dart';
import 'package:web_app/ui/page/home/admin/components/manufacturers_manager/manufacturers_manager_view.dart';

import '../size_manager/size_manager_view.dart';

class CategoryTest extends StatelessWidget {
  const CategoryTest({super.key});

  // List<Widget> _getChildren1() {
  //   return titleList.map((e) => Center(child: Text(e))).toList();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabContainer(
        // radius: 20,
        tabEdge: TabEdge.top,
        tabCurve: Curves.easeIn,
        transitionBuilder: (child, animation) {
          animation = CurvedAnimation(curve: Curves.easeIn, parent: animation);
          return SlideTransition(
            position: Tween(
              begin: const Offset(0.2, 0.0),
              end: const Offset(0.0, 0.0),
            ).animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        colors: <Color>[
          Colors.lightBlue.shade50,
          Colors.lightBlue.shade50,
          Colors.lightBlue.shade50,
          Colors.lightBlue.shade50,
        ],

        selectedTextStyle: const TextStyle(fontSize: 15.0, color: Colors.black),
        unselectedTextStyle:
            const TextStyle(fontSize: 13.0, color: Colors.grey),
        tabs: titleList,
        children: bodyTab,
      ),
    );
  }
}

const List<String> titleList = [
  'Danh mục giày',
  'Danh mục nhà sản xuất',
  'Danh mục màu sắc',
  'Danh mục size'
];

const List<Widget> bodyTab = [
  CategoryManagerView(),
  ManufacturersManagerView(),
  ColorManagerView(),
  SizeManagerView(),
];
