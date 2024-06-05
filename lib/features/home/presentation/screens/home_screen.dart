import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ravenpay_assessment/core/extensions/ui_extension.dart';
import 'package:ravenpay_assessment/features/home/presentation/states/interval_notifier.dart';
import 'package:ravenpay_assessment/features/home/presentation/states/stream_controller.dart';
import 'package:ravenpay_assessment/features/home/presentation/widgets/charts_widget.dart';
import 'package:ravenpay_assessment/features/home/presentation/widgets/menu_widget.dart';
import 'package:ravenpay_assessment/features/home/presentation/widgets/order_book_widget.dart';
import 'package:ravenpay_assessment/res.dart';

import '../widgets/change_tab_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void changeIndex(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (ref.watch(priceProvider).value != null) {
        print(ref.watch(priceProvider).value!.s);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final klineEvent = ref.watch(priceProvider);

    double calculatePercentageChange(double open, double close) {
      return (((close - open) / open) * 100);
    }

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: MenuDialog(),

      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   leading: Padding(
      //     padding: const EdgeInsets.only(left: 16),
      //     child: Row(
      //       children: [
      //
      //       ],
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 121.w, height: 34.h, child: Image.asset(Res.logo)),
                  SizedBox(
                    width: context.screenSize.width * 0.3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            height: 32.h,
                            width: 32.w,
                            child: Image.asset(Res.profile)),
                        SvgPicture.asset(Res.globe),
                        IconButton(
                          onPressed: () {
                            showDialog(
                                context: context, builder: (_) => MenuDialog());
                          },
                          icon: SvgPicture.asset(Res.menu),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 1,
              width: context.screenSize.width,
              decoration: const BoxDecoration(color: Color(0xff32383F)),
            ),
            SizedBox(
              height: 10.h,
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            Res.btc,
                            height: 24.h,
                            width: 44.w,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "BTC/USDT",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          SvgPicture.asset(Res.down),
                          SizedBox(
                            width: 15.w,
                          ),
                          klineEvent.when(
                            data: (event) => Text(
                              '\$${event.k.c}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: context.colorScheme.primary),
                            ),
                            loading: () => const CircularProgressIndicator(),
                            error: (error, stack) => Text('Error: $error'),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(Res.clock),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    "24h change",
                                    style: TextStyle(
                                        color: Color(0xffA7B1BC),
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  klineEvent.when(
                                    data: (event) => Text(
                                      '${event.k.c}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: context.colorScheme.primary),
                                    ),
                                    loading: () =>
                                        const CircularProgressIndicator(),
                                    error: (error, stack) =>
                                        Text('Error: $error'),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  klineEvent.when(
                                    data: (event) => Text(
                                      '${calculatePercentageChange(double.parse(event.k.o), double.parse(event.k.c)).toStringAsFixed(2)}%',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: context.colorScheme.primary),
                                    ),
                                    loading: () =>
                                        const CircularProgressIndicator(),
                                    error: (error, stack) =>
                                        Text('Error: $error'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(Res.up),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  const Text(
                                    "24h high",
                                    style: TextStyle(
                                        color: Color(0xffA7B1BC),
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  klineEvent.when(
                                    data: (event) => Text(
                                      '${event.k.h}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: context
                                              .colorScheme.onPrimaryContainer),
                                    ),
                                    loading: () =>
                                        const CircularProgressIndicator(),
                                    error: (error, stack) =>
                                        Text('Error: $error'),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  klineEvent.when(
                                    data: (event) => Text(
                                      '${calculatePercentageChange(double.parse(event.k.o), double.parse(event.k.h)).toStringAsFixed(2)}%',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: context
                                              .colorScheme.onPrimaryContainer),
                                    ),
                                    loading: () =>
                                        const CircularProgressIndicator(),
                                    error: (error, stack) =>
                                        Text('Error: $error'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(Res.arrow_down),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  const Text(
                                    "24h low",
                                    style: TextStyle(
                                        color: Color(0xffA7B1BC),
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  klineEvent.when(
                                    data: (event) => Text(
                                      '${event.k.l}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: context
                                              .colorScheme.onPrimaryContainer),
                                    ),
                                    loading: () =>
                                        const CircularProgressIndicator(),
                                    error: (error, stack) =>
                                        Text('Error: $error'),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  klineEvent.when(
                                    data: (event) => Text(
                                      '${calculatePercentageChange(double.parse(event.k.o), double.parse(event.k.l)).toStringAsFixed(2)}%',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: context
                                              .colorScheme.onPrimaryContainer),
                                    ),
                                    loading: () =>
                                        const CircularProgressIndicator(),
                                    error: (error, stack) =>
                                        Text('Error: $error'),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 10.h,
              width: context.screenSize.width,
              decoration: const BoxDecoration(color: Color(0xff32383F)),
            ),
            // SizedBox(
            //   height: 10.h,
            // ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 40.h,
                width: context.screenSize.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border:
                        Border.all(color: const Color(0xff262932), width: 1),
                    color: const Color(
                      0xff1C2127,
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ChangeTabWidget(
                        title: "Charts",
                        isCurrent: _selectedIndex == 0,
                        onTap: () {
                          changeIndex(0);
                        },
                      ),
                      ChangeTabWidget(
                        title: "OrderBook",
                        isCurrent: _selectedIndex == 1,
                        onTap: () {
                          changeIndex(1);
                        },
                      ),
                      ChangeTabWidget(
                        title: "Recent Trades",
                        isCurrent: _selectedIndex == 2,
                        onTap: () {
                          changeIndex(2);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),

            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  const ChartsWidget(),
                  const OrderBookWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
