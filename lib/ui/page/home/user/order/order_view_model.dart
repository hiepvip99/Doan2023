// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:web_app/model/network/discount_model.dart';
import 'package:web_app/model/network/order_manager_model.dart';
import 'package:web_app/model/network/product_manager_model.dart';
import 'package:web_app/service/network/cart_service.dart';
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
  RxString base64Image = ''.obs;

  CustomerService customerService = CustomerService();
  OrderService orderService = OrderService();
  DiscountService discountService = DiscountService();
  Rx<Customer> customer = Rx(Customer());

  final accountId = DataLocal.getAccountId();
  ColorService colorNetworkService = ColorService();
  SizeService sizeNetworkService = SizeService();
  CartService cartService = CartService();

  RxList<ColorShoe> colorList = RxList();
  RxList<Size> sizeList = RxList();

  RxInt discount = 0.obs;
  RxBool loading = false.obs;

  Future<void> genarateQr() async {
    loading.value = true;
    int? maxId;
    await orderService.getMaxId().then((value) {
      if (value?.maxId != null) {
        maxId = value?.maxId;
      }
    });
    // base64Image.
    await orderService
        .genarateQr(GetQrGenarate(
            accountNo: '4520561495',
            accountName: 'LE CHI HIEP',
            acqId: 970418,
            amount: getTotalPrice(),
            addInfo: 'Pay to order id: ${(maxId ?? 0) + 1}',
            format: 'text',
            template: '96KCB5S'))
        .then((value) {
      if (value?.data?.qrDataURL != null) {
        base64Image.value = value?.data?.qrDataURL ?? '';
      }
    });

    loading.value = false;
  }

  Future<void> applyDiscount(String code) async {
    discount.value = 0;
    discountService
        .applyDiscount(DiscountModel(
            discountToApply: Discount(code: code),
            customerId: customer.value.id))
        .then((value) {
      if (value?.success == true) {
        genarateQr();
        discount.value = value?.discount ?? 0;
      } else {
        // DialogCommon().showAlertDialog(
        //     context: Get.context!,
        //     title: 'Áp dụng mã giảm giá không thành công');
        DialogCommon()
            .showAlertDialog(context: Get.context!, title: '${value?.message}');
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
    await orderService.addOrder(order.value).then((value) async {
      if (value?.statusCode == 200) {
        for (var i = 0; i < orderProduct.value.length; i++) {
          cartService.deleteCart(orderProduct.value[i].productInCart);
        }
        int? maxId;
        await orderService.getMaxId().then((value) {
          if (value?.maxId != null) {
            maxId = value?.maxId;
          }
          order.value.id = maxId;
          // cartService.deleteCart(orderProduct)
          Get.off(() => OrderSuccessScreen(
                isQrCode:
                    radioselectedPaymentMethod.value == 'Thanh toán qua Qr',
                order: order.value,
              ));
        });
        
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
        .getAllColor(step: 1000)
        .then((value) => colorList.value = value?.color ?? []);
    sizeNetworkService
        .getAllSize(step: 1000)
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
    int ship = 30000;
    if (total >= 500000) {
      ship = 0;
    }
    return total - discount.value + ship;
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
