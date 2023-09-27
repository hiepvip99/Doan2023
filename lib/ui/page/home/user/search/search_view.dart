import 'package:flutter/material.dart';
import 'package:web_app/ui/component_common/textfield_common.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  static String route = '/SearchView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 54,
        elevation: 0,
        // backgroundColor: Colors.white,
        title: Row(
          children: [
            Expanded(
                child: TextFieldCommon(
              border: InputBorder.none,
              backgroundColor: Colors.grey.shade200,
              controller: TextEditingController(),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            )),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.search),
              ))
        ],
      ),
      body: const Column(
        children: [Text('Danh sách sản phẩm hiển thị ở đây')],
      ),
    );
  }
}
