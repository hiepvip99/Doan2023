import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';

class PaginatorCommon extends StatefulWidget {
  const PaginatorCommon(
      {super.key,
      this.initPage = 1,
      this.onPageChangeCallBack,
      required this.totalPage})
      : assert(initPage >= 0);

  final int initPage;
  final int totalPage;
  final Function(int)? onPageChangeCallBack;

  @override
  State<PaginatorCommon> createState() => _PaginatorCommonState();
}

class _PaginatorCommonState extends State<PaginatorCommon> {
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initPage;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 450,
        child: Theme(
          data: ThemeData(
              iconTheme: IconThemeData(
                  color: (_currentPage > 1) && (_currentPage < widget.totalPage)
                      ? Colors.blue
                      : Colors.grey)),
          child: NumberPaginator(
            numberPages: widget.totalPage,
            onPageChange: (int index) {
              setState(() {
                _currentPage = index;
              });
              if (widget.onPageChangeCallBack != null) {
                widget.onPageChangeCallBack!(index);
              }
            },
            initialPage: _currentPage,
            config: const NumberPaginatorUIConfig(
              height: 50,
              buttonShape: CircleBorder(),
              buttonSelectedForegroundColor: Colors.white,
              buttonUnselectedForegroundColor: Colors.blue,
              buttonUnselectedBackgroundColor: Colors.white,
              buttonSelectedBackgroundColor: Colors.blue,
              // buttonSelectedForegroundColor: Colors.yellow,
              // buttonUnselectedForegroundColor: Colors.white,
              // buttonUnselectedBackgroundColor: Colors.grey,
              // buttonSelectedBackgroundColor: Colors.blueGrey,
            ),
          ),
        ),
      ),
    );
  }
}
