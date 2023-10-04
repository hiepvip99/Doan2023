import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:web_app/ui/component_common/textfield_common.dart';

import '../../../../../model/network/product_manager_model.dart';
import '../common/product_card.dart';
import 'search_view_model.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  static String route = '/SearchView';

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  RxInt index = 0.obs;

  static const _pageSize = 10;
  final viewModel = SearchViewModel();

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
    txtSearch.dispose();
    txtMinPrice.dispose();
    txtMaxPrice.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final txtSearch = TextEditingController();
  final txtMinPrice = TextEditingController();
  final txtMaxPrice = TextEditingController();

  RxString validatePrice = RxString('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      endDrawer: searchFilter(),
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
                controller: txtSearch,
                // onChanged: (value) {
                //   viewModel.keyword.value = value;
                //   // viewModel.getAllProduct();
                //   _pagingController.refresh();
                //   // _fetchPage(1);
                // },
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                viewModel.keyword.value = txtSearch.text.trim();
                _pagingController.refresh();
              },
              icon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.search),
              )),
          IconButton(
              onPressed: () {
                _key.currentState!.openEndDrawer();
              },
              icon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.filter_list_alt),
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('Danh sách sản phẩm hiển thị ở đây'),
              PagedGridView<int, Product>(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 16),
                physics: const NeverScrollableScrollPhysics(),
                pagingController: _pagingController,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    maxCrossAxisExtent: 175,
                    childAspectRatio: 0.75),
                builderDelegate: PagedChildBuilderDelegate<Product>(
                  itemBuilder: (context, item, index) => ProductCard(
                    // beer: item,
                    product: item,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Drawer searchFilter() {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Chức năng đang làm'),
            const SizedBox(
              height: 16,
            ),
            const Text('Tìm theo khoảng giá:'),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFieldCommon(
                    border: InputBorder.none,
                    hintText: 'từ',
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    backgroundColor: Colors.grey.shade200,
                    controller: txtMinPrice,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: TextFieldCommon(
                    border: InputBorder.none,
                    backgroundColor: Colors.grey.shade200,
                    controller: txtMaxPrice,
                    hintText: 'đến',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                )
              ],
            ),
            DropdownMenu<String>(
              initialSelection: list.first,
              onSelected: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  // dropdownValue = value!;
                });
              },
              dropdownMenuEntries:
                  list.map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
            ),
            Obx(
              () => Visibility(
                  visible: validatePrice.value.isNotEmpty,
                  child: Text('${validatePrice.value}')),
            )
          ],
        ),
      ),
    );
  }
}
const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
