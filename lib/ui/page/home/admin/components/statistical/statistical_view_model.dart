import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

import '../../../../../../service/network/statistical_service.dart';
import 'statistical_view.dart';

class StatisticalViewModel extends GetxController {
  RxList<DataForChart> dataDayDataForChart = RxList();
  RxList<DataForChart> dataMonthDataForChart = RxList();
  RxInt total = 0.obs;
  Rx<DateTime> fromDate = Rx(DateTime.now());
  Rx<DateTime> toDate = Rx(DateTime.now());

  RxBool loading = false.obs;
  RxBool isMonth = false.obs;

  StatisticalService networkService = StatisticalService();

  @override
  void onInit() {
    super.onInit();
    getDataDay();
  }

  Future<void> getDataDay() async {
    loading.value = true;
    isMonth.value = false;
    await networkService
        .getStatisticalByDay(fromDate: fromDate.value, toDate: toDate.value)
        .then((value) {
      // dataDayDataForChart.value = value.byDayList.map((e) => DataForChart(x, y))
      if (value != null) {
        if (value.byDayList != null) {
          dataDayDataForChart.clear();
          for (var i = 0; i < value.byDayList!.length; i++) {
            dataDayDataForChart.add(DataForChart(
                '${value.byDayList![i].day?.day ?? ''}/${value.byDayList![i].day?.month ?? ''}',
                value.byDayList![i].revenue?.toDouble() ?? 0.0));
          }
        }
        total.value = value.totalRevenue ?? 0;
      }
    });
    loading.value = false;
  }

  Future<void> getDataMonth() async {
    loading.value = true;
    isMonth.value = true;
    await networkService
        .getStatisticalByMonth(fromDate: fromDate.value, toDate: toDate.value)
        .then((value) {
      // dataMonthDataForChart.value = value.byMonthList.map((e) => DataForChart(x, y))
      if (value != null) {
        if (value.byMonthList != null) {
          dataMonthDataForChart.clear();
          for (var i = 0; i < value.byMonthList!.length; i++) {
            dataMonthDataForChart.add(DataForChart(
                '${value.byMonthList![i].month}',
                value.byMonthList![i].revenue?.toDouble() ?? 0.0));
          }
        }
        total.value = value.totalRevenue ?? 0;
      }
    });
    loading.value = false;
  }
}
