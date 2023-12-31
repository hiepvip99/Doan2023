// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../../../../../extendsion/extendsion.dart';
import '../../../../../../model/network/statistical_model.dart';
import 'statistical_view_model.dart';

class Statistical extends StatefulWidget {
  const Statistical({Key? key}) : super(key: key);

  @override
  State<Statistical> createState() => _StatisticalState();
}

class _StatisticalState extends State<Statistical> {
  final StatisticalViewModel viewModel = Get.find<StatisticalViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Biểu đồ thống kê'),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Obx(() => Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Tổng doanh thu: ${formatMoney(viewModel.total.value)}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(
                    () => Row(
                      children: [
                        Text(
                            'Từ ngày: ${formatDate(viewModel.fromDate.value)}'),
                        const SizedBox(
                          width: 20,
                        ),
                        IconButton(
                            onPressed: () async {
                              showDatePicker(context, true);
                            },
                            icon: const Icon(Icons.date_range)),
                        const SizedBox(
                          width: 20,
                        ),
                        Text('Đến ngày: ${formatDate(viewModel.toDate.value)}'),
                        const SizedBox(
                          width: 20,
                        ),
                        IconButton(
                            onPressed: () async {
                              showDatePicker(context, false);
                            },
                            icon: const Icon(Icons.date_range)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        viewModel.getDataDay();
                      },
                      child: const Text('Thống kê theo ngày')),
                  const SizedBox(
                    width: 50,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        viewModel.getDataMonth();
                      },
                      child: const Text('Thống kê theo tháng')),
                  const SizedBox(
                    width: 50,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        viewModel.getProductStatistical();
                      },
                      child: const Text('Thống kê sản phẩm')),
                ],
              ),
            ),
          ),
          //Initialize the chart widget
          
          Expanded(
            child: Obx(
              () => !viewModel.isProduct.value
                  ? SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  // Chart title
                  title: ChartTitle(text: 'Biểu đồ thống kê'),
                  // Enable legend
                  legend: const Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<DataForChart, String>>[
                    LineSeries<DataForChart, String>(
                        dataSource: viewModel.isMonth.value
                            ? viewModel.dataMonthDataForChart.value
                            : viewModel.dataDayDataForChart.value,
                        xValueMapper: (DataForChart sales, _) => sales.year,
                        yValueMapper: (DataForChart sales, _) => sales.sales,
                        name: 'Doanh thu',
                        // Enable data label
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true))
                        ])
                  : SfCircularChart(
                      series: <CircularSeries>[
                        PieSeries<ProductThongKe, String>(
                            name: 'Sản phẩm bán chạy',
                            dataLabelMapper: (data, index) =>
                                '${data.name}\n${data.totalQuantity} chiếc',
                            dataSource: viewModel.thongkeProduct.value,
                            xValueMapper: (ProductThongKe data, _) => data.name,
                            yValueMapper: (ProductThongKe data, _) =>
                                data.totalQuantity,
                            // dataLabelMapper: ,
                            dataLabelSettings: const DataLabelSettings(
                              isVisible: true,
                            )),
                      ],
                    ),
            ),
          ),
          // Expanded(
          //   child: Obx(
          //     () => ,
          //   ),
          // ),
        ]));
  }

  Future<void> showDatePicker(BuildContext context, bool isFromDate) {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: ScrollConfiguration(
            behavior: MyCustomScrollBehavior(),
            child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                use24hFormat: true,
                onDateTimeChanged: (value) => isFromDate
                    ? viewModel.fromDate.value = value
                    : viewModel.toDate.value = value,
                initialDateTime: isFromDate
                    ? viewModel.fromDate.value
                    : viewModel.toDate.value,
                minimumDate: DateTime(1990),
                maximumDate: DateTime(2050)),
          ),
        ),
      ),
    );
  }
}

class DataForChart {
  DataForChart(this.year, this.sales);

  final String year;
  final double sales;
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

class PieData {
  final String category;
  final double value;

  PieData(this.category, this.value);
}
