import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ravenpay_assessment/core/extensions/ui_extension.dart';
import 'package:ravenpay_assessment/features/home/domain/model/order_book.dart';
import 'package:ravenpay_assessment/features/home/presentation/states/order_book_data_controller.dart';
import 'package:ravenpay_assessment/res.dart';
import 'package:web_socket_channel/io.dart';

import 'order_widget.dart';

class OrderBookWidget extends ConsumerStatefulWidget {
  const OrderBookWidget({super.key});

  @override
  ConsumerState createState() => _OrderBookWidgetState();
}

class _OrderBookWidgetState extends ConsumerState<OrderBookWidget> {
  @override
  Widget build(BuildContext context) {
    final orderBookEvent = ref.watch(orderBookProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: context.screenSize.width * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: 32.h,
                          width: 32.w,
                          decoration:
                              const BoxDecoration(color: Color(0xff353945)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(Res.order_chart_one),
                          )),
                      SvgPicture.asset(Res.order_chart_two),
                      SvgPicture.asset(Res.order_chart_three),
                    ],
                  ),
                ),
                Container(
                    height: 32.h,
                    //   width: 32.w,
                    decoration: const BoxDecoration(color: Color(0xff353945)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          "10",
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(Res.down),
                        ),
                      ],
                    )),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Price\n(USDT)",
                  style: TextStyle(
                      color: Color(0xffA7B1BC),
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp),
                ),
                Text(
                  "Amounts\n(BTC)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xffA7B1BC),
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp),
                ),
                Text(
                  "Total",
                  style: TextStyle(
                      color: Color(0xffA7B1BC),
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            orderBookEvent.when(
              data: (event) => Column(
                children: [
                  SizedBox(
                    height: 150.h,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 5,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          Order order = event.asks.elementAt(index);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  order.price.toStringAsFixed(2),
                                  style: TextStyle(
                                      color: const Color(0xffFF6838),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                ),
                                Text(
                                  order.quantity.toString(),
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: context.colorScheme.onSurface,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                ),
                                Text(
                                  (order.price * order.quantity)
                                      .toStringAsFixed(2),
                                  style: TextStyle(
                                      color: context.colorScheme.onSurface,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 150.h,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 5,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          Order order = event.bids.elementAt(index);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  order.price.toStringAsFixed(2),
                                  style: TextStyle(
                                      color: context.colorScheme.primary,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                ),
                                Text(
                                  order.quantity.toString(),
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: context.colorScheme.onSurface,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                ),
                                Text(
                                  (order.price * order.quantity)
                                      .toStringAsFixed(2),
                                  style: TextStyle(
                                      color: context.colorScheme.onSurface,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Error: $error'),
            ),
            SizedBox(
              height: 20.h,
            ),
            const OrdersWidget()
          ],
        ),
      ),
    );
  }
}
