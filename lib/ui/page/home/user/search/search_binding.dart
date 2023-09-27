import 'package:get/get.dart';

import 'search_view_model.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchViewModel());
  }
}
