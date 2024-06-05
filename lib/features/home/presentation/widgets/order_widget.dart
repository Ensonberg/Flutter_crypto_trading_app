import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ravenpay_assessment/core/extensions/ui_extension.dart';
import 'package:ravenpay_assessment/features/home/presentation/widgets/trade_order_bottom_sheet.dart';

import 'change_tab_widget.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({Key? key}) : super(key: key);

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  int _selectedIndex = 0;

  void changeIndex(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            height: 40.h,
            width: context.screenSize.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: const Color(0xff262932), width: 1),
                color: Colors.black.withOpacity(0.06)),
            child: Padding(
                padding: const EdgeInsets.all(4),
                child: ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  children: [
                    ChangeTabWidget(
                      width: 150,
                      title: context.tr.open_orders,
                      isCurrent: _selectedIndex == 0,
                      onTap: () {
                        changeIndex(0);
                      },
                    ),
                    ChangeTabWidget(
                      width: 150,
                      title: context.tr.positions,
                      isCurrent: _selectedIndex == 1,
                      onTap: () {
                        changeIndex(1);
                      },
                    ),
                    ChangeTabWidget(
                      width: 150,
                      title: context.tr.orders,
                      isCurrent: _selectedIndex == 2,
                      onTap: () {
                        changeIndex(2);
                      },
                    )
                  ],
                )),
          ),
        ),
        SizedBox(
          height: 100.h,
        ),
        Text(
          context.tr.no_open_order,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            context.tr.dummy_text,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Container(
          height: 64.h,
          decoration: BoxDecoration(color: Color(0xff262B31)),
          child: Row(
            children: [
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RawMaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        enableDrag: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.r),
                                topRight: Radius.circular(16.r))),
                        builder: (_) => const TradeOrderBottomSheet());
                  },
                  child: Container(
                    height: 32.h,
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: Text(
                        context.tr.buy,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
              )),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RawMaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  onPressed: () {
                    showBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.r),
                                topRight: Radius.circular(16.r))),
                        builder: (_) => const TradeOrderBottomSheet());
                  },
                  child: Container(
                    height: 32.h,
                    decoration: BoxDecoration(
                      color: context.colorScheme.error,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: Text(
                        context.tr.sell,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
              ))
            ],
          ),
        )
      ],
    );
  }
}
