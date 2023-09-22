import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

import '../../../../../../service/network/statistical_service.dart';

class StatisticalViewModel extends GetxController {
  RxList<FlSpot> dataDayFlSpot = RxList();
  RxList<FlSpot> dataMonthFlSpot = RxList();

  Rx<DateTime> fromDate = Rx(DateTime.now());
  Rx<DateTime> toDate = Rx(DateTime.now());

  RxList<String> titleBottom = RxList();

  StatisticalService networkService = StatisticalService();

  @override
  void onInit() {
    super.onInit();
    getDataDay();
  }

  Future<void> getDataDay() async {
    await networkService
        .getStatisticalByDay(fromDate: fromDate.value, toDate: toDate.value)
        .then((value) {
      // dataDayFlSpot.value = value.byDayList.map((e) => FlSpot(x, y))
      if (value != null) {
        if (value.byDayList != null) {
          titleBottom.clear();
          dataDayFlSpot.clear();
          for (var i = 0; i < value.byDayList!.length; i++) {
            dataDayFlSpot.add(
                FlSpot(i + 1, value.byDayList![i].revenue?.toDouble() ?? 0.0));
            titleBottom.add(
                '${value.byDayList![i].day?.day ?? ''}/${value.byDayList![i].day?.month ?? ''}');
          }
        }
      }
    });
  }

  Future<void> getDataMonth() async {
    await networkService
        .getStatisticalByMonth(fromDate: fromDate.value, toDate: toDate.value)
        .then((value) {
      // dataMonthFlSpot.value = value.byMonthList.map((e) => FlSpot(x, y))
      if (value != null) {
        if (value.byMonthList != null) {
          dataMonthFlSpot.clear();
          titleBottom.clear();
          for (var i = 0; i < value.byMonthList!.length; i++) {
            dataMonthFlSpot.add(FlSpot(
                i + 1, value.byMonthList![i].revenue?.toDouble() ?? 0.0));
            titleBottom.add(
                '${value.byDayList![i].day?.day ?? ''}/${value.byDayList![i].day?.month ?? ''}');
          }
        }
      }
    });
  }
}
