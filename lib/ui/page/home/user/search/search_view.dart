import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:web_app/ui/component_common/textfield_common.dart';
import 'package:web_app/ui/page/home/admin/components/product_manager/product_manager_view.dart';

import '../../../../../constant.dart';
import '../../../../../model/network/category_model.dart';
import '../../../../../model/network/manufacturer_model.dart';
import '../../../../../model/network/product_manager_model.dart';
import '../../../../component_common/test_product_card.dart';
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
  final viewModel = Get.find<SearchViewModel>();

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
      // viewModel.currentPage.value = pageKey;
      viewModel.selectedItem.value = _pageSize.toString();
      await viewModel.getAllProduct();
      final newItems = viewModel.productList;
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
    txtSearch.dispose();
    txtMinPrice.dispose();
    txtMaxPrice.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final txtSearch = TextEditingController();
  final txtMinPrice = TextEditingController();
  final txtMaxPrice = TextEditingController();
  final txtDropManufacture = TextEditingController();
  final txtDropCategory = TextEditingController();
  final txtGender = TextEditingController();

  RxString validatePrice = RxString('');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                  // autofocus: true,
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
                  viewModel.currentPage.value = 1;
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // const Text('Danh sách sản phẩm hiển thị ở đây'),
              Expanded(
                child: PagedGridView<int, Product>(
                  // shrinkWrap: true,
                  // padding: const EdgeInsets.symmetric(vertical: 8),
                  // physics: const NeverScrollableScrollPhysics(),
                  pagingController: _pagingController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3 / 4,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  builderDelegate: PagedChildBuilderDelegate<Product>(
                    noItemsFoundIndicatorBuilder: (context) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          const Text('Không tìm thấy kết sản phẩm phù hợp'),
                          const SizedBox(
                            height: 50,
                          ),
                          const SizedBox(
                              height: 200,
                              width: 200,
                              child: ImageComponent(
                                  isShowBorder: false,
                                  imageUrl:
                                      domain + 'api/image/not_found.png')),
                          const SizedBox(
                            height: 50,
                          ),
                          removeFilterButton(),
                        ],
                      ),
                    ),
                    itemBuilder: (context, item, index) => TestProductCard(
                      // beer: item,
                      product: item,
                    ),
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
            // const Text('Chức năng đang làm'),
            const SizedBox(
              height: 24,
            ),
            const Text(
              'Tìm theo khoảng giá:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFieldCommon(
                    border: InputBorder.none,
                    hintText: 'Từ',
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
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    hintText: 'Đến',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Nhà sản xuất:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Obx(
              () => DropdownMenu<Manufacturer>(
                width: 290,
                // menuHeight: 36,
                // inputDecorationTheme: InputDecorationTheme(),
                controller: txtDropManufacture,
                initialSelection: viewModel.manufacturer.value.id != null
                    ? viewModel.manufacturerList
                        .where((e) => e.id == viewModel.manufacturer.value.id)
                        .toList()
                        .first
                    : null,
                // enableSearch: true,
                onSelected: (Manufacturer? value) {
                  if (value != null) {
                    viewModel.manufacturer.value = value;
                    // product.manufacturerId = value.id;
                  }
                },
                dropdownMenuEntries: viewModel.manufacturerList.value
                    .map<DropdownMenuEntry<Manufacturer>>(
                  (Manufacturer value) {
                    return DropdownMenuEntry<Manufacturer>(
                        value: value, label: value.name ?? '');
                  },
                ).toList(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Loại giày:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Obx(
              () => DropdownMenu<Category>(
                width: 290,
                controller: txtDropCategory,
                initialSelection: viewModel.category.value.id != null
                    ? viewModel.categoryList
                        .where((e) => e.id == viewModel.category.value.id)
                        .toList()
                        .first
                    : null,
                onSelected: (Category? value) {
                  if (value != null) {
                    viewModel.category.value = value;
                    // product.categoryId = value.id;
                  }
                },
                dropdownMenuEntries: viewModel.categoryList.value
                    .map<DropdownMenuEntry<Category>>(
                  (Category value) {
                    return DropdownMenuEntry<Category>(
                        value: value, label: value.name ?? '');
                  },
                ).toList(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Giới tính:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            DropdownMenu<String>(
                width: 290,
                // trailingIcon: Icon(Icons.home),
                // inputDecorationTheme: InputDecorationTheme(
                //     contentPadding: EdgeInsets.only(left: 10),
                //     border: OutlineInputBorder(),
                //     // isCollapsed: true,
                //     isDense: true,
                //     constraints: BoxConstraints(maxHeight: 40)),

                controller: txtGender,
                initialSelection: viewModel.gender,
                onSelected: (String? value) {
                  if (value != null) {
                    viewModel.gender = value;
                  }
                },
                dropdownMenuEntries:
                    genderList.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList()),

            const SizedBox(height: 16),
            // DropdownMenu<Category>(
            //     initialSelection: product.categoryId != null
            //         ? viewModel.categoryList
            //             .where((e) => e.id == product.categoryId)
            //             .toList()
            //             .first
            //         : viewModel.categoryList.first,
            //     onSelected: (Category? value) {
            //       if (value != null) {
            //         product.categoryId = value.id;
            //       }
            //     },
            //     dropdownMenuEntries: viewModel.categoryList
            //         .map<DropdownMenuEntry<Category>>((Category value) {
            //       return DropdownMenuEntry<Category>(
            //           value: value, label: value.name ?? '');
            //     }).toList()),
            // DropdownMenu<String>(
            //   initialSelection: list.first,
            //   onSelected: (String? value) {
            //     // This is called when the user selects an item.
            //     setState(() {
            //       // dropdownValue = value!;
            //     });
            //   },
            //   dropdownMenuEntries:
            //       list.map<DropdownMenuEntry<String>>((String value) {
            //     return DropdownMenuEntry<String>(value: value, label: value);
            //   }).toList(),
            // ),
            Obx(
              () => Visibility(
                  visible: validatePrice.value.isNotEmpty,
                  child: Text(
                    validatePrice.value,
                    style: const TextStyle(color: Colors.red),
                  )),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        viewModel.currentPage.value = 1;
                        viewModel.keyword.value = txtSearch.text.trim();
                        validatePrice.value = '';
                        viewModel.minPrice = int.tryParse(txtMinPrice.text);
                        viewModel.maxPrice = int.tryParse(txtMaxPrice.text);
                        if (viewModel.minPrice != null &&
                            viewModel.maxPrice != null) {
                          if (viewModel.minPrice! > viewModel.maxPrice!) {
                            validatePrice.value =
                                'Vui lòng điền khoảng giá phù hợp';
                          } else {
                            viewModel.currentPage.value = 1;
                            // if (viewModel.minPrice! > viewModel.maxPrice!) {}
                            _pagingController.refresh();
                          }
                        } else {
                          _pagingController.refresh();
                        }
                        Get.back();
                      },
                      child: const Text('Áp dụng')),
                  removeFilterButton(),
                ],
              ),
            ),
            // DropdownButtonFormField(
            //   decoration: InputDecoration(border: OutlineInputBorder()),
            //   items: genderList
            //       .map((e) => DropdownMenuItem(
            //             child: Text(e),
            //             value: e,
            //           ))
            //       .toList(),
            //   value: viewModel.gender,
            //   onChanged: (value) {
            //     // if (value != null) {
            //     //   viewModel.gender = value;
            //     // }
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  ElevatedButton removeFilterButton() {
    return ElevatedButton(
        onPressed: () {
          viewModel.removeFilter();
          txtMaxPrice.text = '';
          txtMinPrice.text = '';
          txtDropManufacture.text = '';
          txtDropCategory.text = '';
          txtGender.text = '';
          _pagingController.refresh();
          // Get.back();
        },
        child: const Text('Xoá bộ lọc'));
  }
}

// const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
List<String> genderList = ['Nam', 'Nữ'];
