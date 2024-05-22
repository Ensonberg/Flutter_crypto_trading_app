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
import 'package:ravenpay_assessment/res.dart';

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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CupertinoActivityIndicator()),
              ],
            ),
          if (ref.watch(homeProvider).data.isNotEmpty)
            SizedBox(
              height: context.screenSize.height * 0.5,
              child: InteractiveChart(
                /** Only [candles] is required */
                candles: ref.watch(homeProvider).data,

                style: ChartStyle(
                  //priceGainColor: Colors.teal[200]!,
                  // priceLossColor: Colors.blueGrey,
                  // volumeColor: Colors.teal.withOpacity(0.8),
                  trendLineStyles: [
                    Paint()
                      ..strokeWidth = 16.0
                      ..strokeCap = StrokeCap.round
                      ..color = Colors.deepOrange,
                    Paint()
                      ..strokeWidth = 16.0
                      ..strokeCap = StrokeCap.round
                      ..color = Colors.orange,
                  ],
                  priceGridLineColor: Color(0xffA7B1BC)!,
                  priceLabelStyle: TextStyle(
                      color: Color(0xffA7B1BC),
                      fontWeight: FontWeight.w500,
                      fontSize: 8),
                  timeLabelStyle:
                      TextStyle(color: context.colorScheme.onSurface),
                  selectionHighlightColor: Colors.red.withOpacity(0.2),
                  overlayBackgroundColor: Color(0xff00C076),
                  overlayTextStyle:
                      TextStyle(color: context.colorScheme.onSurface),
                  timeLabelHeight: 32.h,
                  volumeColor: Colors.green.withOpacity(0.5),

                  volumeHeightFactor: 0.2, // volume area is 20% of total height
                ),
                /** Customize axis labels */
                // timeLabel: (timestamp, visibleDataCount) => "📅",
                // priceLabel: (price) => "${price.round()} 💎",
                /** Customize overlay (tap and hold to see it)
       ** Or return an empty object to disable overlay info. */
                // overlayInfo: (candle) => {
                //   "💎": "🤚    ",
                //   "Hi": "${candle.high?.toStringAsFixed(2)}",
                //   "Lo": "${candle.low?.toStringAsFixed(2)}",
                // },
                /** Callbacks */
                onTap: (candle) => print("user tapped on $candle"),
                onCandleResize: (width) => print("each candle is $width wide"),
              ),
            ),
          SizedBox(
            height: 20.h,
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
