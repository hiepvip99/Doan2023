import 'package:get/get.dart';
import 'package:web_app/model/network/discount_model.dart';
import 'package:web_app/model/network/order_manager_model.dart';
import 'package:web_app/model/network/product_manager_model.dart';
import 'package:web_app/service/network/discount_service.dart';
import 'package:web_app/ui/dialog/dialog_common.dart';

import '../../../../../model/network/color_model.dart';
import '../../../../../model/network/customer_model.dart';
import '../../../../../model/network/size_model.dart';
import '../../../../../service/local/save_data.dart';
import '../../../../../service/network/color_service.dart';
import '../../../../../service/network/customer_service.dart';
import '../../../../../service/network/order_service.dart';
import '../../../../../service/network/size_service.dart';
import '../cart/cart_view_model.dart';
import '../my_order_manager/components/order_success.dart';

class OrderViewModel extends GetxController {
  Rx<Order> order = Rx(Order());

  RxList<ProductCartModel> orderProduct = RxList();
  RxString radioAddressValue = ''.obs;
  RxString radioselectedPaymentMethod = 'Thanh toán khi nhận hàng'.obs;

  CustomerService customerService = CustomerService();
  OrderService orderService = OrderService();
  DiscountService discountService = DiscountService();
  Rx<Customer> customer = Rx(Customer());

  final accountId = DataLocal.getAccountId();
  ColorService colorNetworkService = ColorService();
  SizeService sizeNetworkService = SizeService();

  RxList<ColorShoe> colorList = RxList();
  RxList<Size> sizeList = RxList();

  RxInt discount = 0.obs;

  Future<void> applyDiscount(String code) async {
    discount.value = 0;
    discountService
        .applyDiscount(DiscountModel(
            discountToApply: Discount(code: code),
            customerId: customer.value.id))
        .then((value) {
      if (value?.success == true) {
        discount.value = value?.discount ?? 0;
      } else {
        DialogCommon().showAlertDialog(
            context: Get.context!,
            title: 'Áp dụng mã giảm giá không thành công');
      }
    });
  }

  Future<void> createOrder() async {
    order.value.customerInfo = customer.value;
    order.value.paymentMethods = radioselectedPaymentMethod.value;
    order.value.totalPrice = getTotalPrice();
    order.value.totalQuantity = getTotalQuantity();
    order.value.details = orderProduct
        .map((e) => Details(
            product: Product(id: e.productInCart.productId),
            color: ColorItemProduct(colorId: e.productInCart.colorId),
            quantity: e.productInCart.quantity,
            sizeId: e.productInCart.sizeId))
        .toList();
    order.value.orderDate = DateTime.now();
    order.value.deliveryAddress = radioAddressValue.value;
    order.value.statusId = 1; // mặc định chờ xác nhận
    await orderService.addOrder(order.value).then((value) {
      if (value?.statusCode == 200) {
        Get.toNamed(OrderSuccessScreen.route);
      } else {
        // DialogCommon().showAlertDialog(
        //     context: Get.context!, title: value?.message ?? '');
      }
    });
  }

  Future<void> getInfomationForProduct() async {
    customerService.getCustomerById(accountId: accountId).then((value) {
      value != null ? customer.value = value : null;
      if (customer.value.address?.length != 0) {
        radioAddressValue.value = customer.value.address!.first;
        // customerId = customer.value.id
      }
    });
    colorNetworkService
        .getAllColor()
        .then((value) => colorList.value = value?.color ?? []);
    sizeNetworkService
        .getAllSize()
        .then((value) => sizeList.value = value?.size ?? []);
  }

  @override
  void onInit() {
    super.onInit();
    final data = Get.arguments;
    if (data is List<ProductCartModel>) {
      orderProduct.value = data;
    }
    getInfomationForProduct();
    accountId;
  }

  int getTotalPrice() {
    int total = 0;
    for (var element in orderProduct.value) {
      total += (element.productInCart.price ?? 0) *
          (element.productInCart.quantity ?? 0);
    }
    return total - discount.value;
  }

  int getTotalQuantity() {
    int total = 0;
    for (var element in orderProduct.value) {
      total += (element.productInCart.quantity ?? 0);
    }
    return total;
  }

  String getColorName(int? colorId) {
    return colorList
            .firstWhereOrNull((element) => element.id == colorId)
            ?.name ??
        '';
  }

  String getSizeName(int? sizeId) {
    return sizeList.firstWhereOrNull((element) => element.id == sizeId)?.name ??
        '';
  }
}
