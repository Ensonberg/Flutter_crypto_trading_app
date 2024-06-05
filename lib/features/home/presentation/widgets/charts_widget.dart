import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:interactive_chart/interactive_chart.dart';
import 'package:ravenpay_assessment/core/extensions/ui_extension.dart';
import 'package:ravenpay_assessment/features/home/presentation/controllers/home_controller.dart';
import 'package:ravenpay_assessment/features/home/presentation/states/chart_data_stream_controller.dart';
import 'package:ravenpay_assessment/features/home/presentation/states/interval_notifier.dart';
import 'package:ravenpay_assessment/features/home/presentation/widgets/order_widget.dart';
import 'package:ravenpay_assessment/res.dart';

import 'change_tab_widget.dart';

class ChartsWidget extends ConsumerStatefulWidget {
  const ChartsWidget({super.key});

  @override
  ConsumerState createState() => _ChartsWidgetState();
}

class _ChartsWidgetState extends ConsumerState<ChartsWidget> {
  int _selectedIndex = 3;

  void changeIndex(int index, String interval) async {
    _selectedIndex = index;
    setState(() {});
    await ref
        .watch(homeProvider)
        .fetchChartData(symbol: "BTCUSDT", interval: interval, limit: 50);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .watch(homeProvider)
          .fetchChartData(symbol: "BTCUSDT", interval: "1d", limit: 50);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var intervalNotifier = ref.read(intervalProvider.notifier);
    final klineEvent = ref.watch(chatDataProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Time",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: context.colorScheme.onPrimary),
                ),
                DurationIndicatorWidget(
                    title: "1H",
                    isCurrent: _selectedIndex == 0,
                    onTap: () async {
                      changeIndex(0, "1h");
                      intervalNotifier.updateInterval("1h");
                    }),
                DurationIndicatorWidget(
                    title: "2H",
                    isCurrent: _selectedIndex == 1,
                    onTap: () {
                      changeIndex(1, "2h");
                      intervalNotifier.updateInterval("2h");
                    }),
                DurationIndicatorWidget(
                    title: "4H",
                    isCurrent: _selectedIndex == 2,
                    onTap: () {
                      changeIndex(2, "4h");
                      intervalNotifier.updateInterval("4h");
                    }),
                DurationIndicatorWidget(
                    title: "1D",
                    isCurrent: _selectedIndex == 3,
                    onTap: () {
                      changeIndex(3, "1d");
                      intervalNotifier.updateInterval("1d");
                    }),
                DurationIndicatorWidget(
                    title: "1W",
                    isCurrent: _selectedIndex == 4,
                    onTap: () {
                      changeIndex(4, "1w");
                      intervalNotifier.updateInterval("1w");
                    }),
                DurationIndicatorWidget(
                    title: "1M",
                    isCurrent: _selectedIndex == 5,
                    onTap: () {
                      changeIndex(5, "1m");
                      intervalNotifier.updateInterval("1m");
                    }),
                SvgPicture.asset(Res.angle_down),
                SvgPicture.asset(Res.candle_chart)
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            height: 1,
            width: context.screenSize.width,
            decoration: const BoxDecoration(color: Color(0xff32383F)),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                Container(
                  width: 104.w,
                  height: 28.h,
                  decoration: BoxDecoration(
                      color: const Color(0xff555C63),
                      borderRadius: BorderRadius.circular(100.r)),
                  child: Center(
                      child: Text(
                    "Trading View",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: context.colorScheme.onSurface),
                  )),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Text(
                  "Depth",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: context.colorScheme.onPrimary),
                ),
                SizedBox(
                  width: 20.w,
                ),
                SvgPicture.asset(Res.expand)
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(Res.box),
                SizedBox(
                  width: 20.w,
                ),
                Text(
                  "BTC/USD",
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: context.colorScheme.onPrimary),
                ),
                Row(
                  children: [
                    Text(
                      "O",
                      style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: context.colorScheme.onPrimary),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    klineEvent.when(
                      data: (event) => Text(
                        '${event.k.o}',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                            color: context.colorScheme.primary),
                      ),
                      loading: () => const CupertinoActivityIndicator(),
                      error: (error, stack) => Text('Error: $error'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "H",
                      style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: context.colorScheme.onPrimary),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    klineEvent.when(
                      data: (event) => Text(
                        '${event.k.h}',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                            color: context.colorScheme.primary),
                      ),
                      loading: () => const CupertinoActivityIndicator(),
                      error: (error, stack) => Text('Error: $error'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "L",
                      style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: context.colorScheme.onPrimary),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    klineEvent.when(
                      data: (event) => Text(
                        '${event.k.l}',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                            color: context.colorScheme.primary),
                      ),
                      loading: () => const CupertinoActivityIndicator(),
                      error: (error, stack) => Text('Error: $error'),
                    ),
                    Row(
                      children: [
                        Text(
                          "C",
                          style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: context.colorScheme.onPrimary),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        klineEvent.when(
                          data: (event) => Text(
                            '${event.k.c}',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 10.sp,
                                color: context.colorScheme.primary),
                          ),
                          loading: () => const CupertinoActivityIndicator(),
                          error: (error, stack) => Text('Error: $error'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            height: 1,
            width: context.screenSize.width,
            decoration: const BoxDecoration(color: Color(0xff32383F)),
          ),
          if (ref.watch(homeProvider).isLoading)
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CupertinoActivityIndicator()),
              ],
            ),
          if (ref.watch(homeProvider).candles.isNotEmpty)
            SizedBox(
              height: context.screenSize.height * 0.4,
              child: Candlesticks(
                candles: ref.watch(homeProvider).candles,
                onLoadMoreCandles: () async {},
                // actions: [ToolBarAction(child: child, onPressed: onPressed)],
              ),
            ),
          // Container(
          //   height: 10.h,
          //   width: context.screenSize.width,
          //   decoration: BoxDecoration(color: context.colorScheme.primary),
          // ),
          SizedBox(
            height: 20.h,
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: OrdersWidget(),
          )
        ],
      ),
    );
  }
}

class DurationIndicatorWidget extends ConsumerWidget {
  final String title;
  final bool isCurrent;
  final VoidCallback onTap;
  const DurationIndicatorWidget(
      {super.key,
      required this.title,
      required this.isCurrent,
      required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 28.h,
        width: 40.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            color: isCurrent ? const Color(0xff555C63) : null),
        child: Center(
            child: Text(
          title,
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: isCurrent
                  ? context.colorScheme.onSurface
                  : context.colorScheme.onPrimary),
        )),
      ),
    );
  }
}
