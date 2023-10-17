import 'package:get/get.dart';
import 'package:web_app/model/network/order_manager_model.dart';
import 'package:web_app/model/network/product_manager_model.dart';

import '../../../../../model/network/color_model.dart';
import '../../../../../model/network/customer_model.dart';
import '../../../../../model/network/size_model.dart';
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
  Rx<Customer> customer = Rx(Customer());

  static const accId = 3;
  ColorService colorNetworkService = ColorService();
  SizeService sizeNetworkService = SizeService();

  RxList<Color> colorList = RxList();
  RxList<Size> sizeList = RxList();

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
      }
    });
  }

  Future<void> getInfomationForProduct() async {
    customerService.getCustomerById(accountId: accId).then((value) {
      value != null ? customer.value = value : null;
      if (customer.value.address?.length != 0) {
        radioAddressValue.value = customer.value.address!.first;
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
    accId;
  }

  int getTotalPrice() {
    int total = 0;
    for (var element in orderProduct.value) {
      total += (element.productInCart.price ?? 0) *
          (element.productInCart.quantity ?? 0);
    }
    return total;
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
