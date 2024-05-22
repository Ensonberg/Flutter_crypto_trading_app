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
              height: 20.h,
            ),
            orderBookEvent.when(
              data: (event) => Column(
                children: [
                  SizedBox(
                    height: 250.h,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: event.asks.length,
                        itemBuilder: (ctx, index) {
                          Order order = event.asks.elementAt(index);

                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            minVerticalPadding: 0,
                            horizontalTitleGap: 0,
                            trailing: Text(
                              (order.price * order.quantity).toStringAsFixed(2),
                              style: TextStyle(
                                  color: context.colorScheme.onSurface,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp),
                            ),
                            title: Center(
                              child: Text(
                                order.quantity.toStringAsFixed(2),
                                style: TextStyle(
                                    color: context.colorScheme.onSurface,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp),
                              ),
                            ),
                            leading: Text(
                              order.price.toStringAsFixed(2),
                              style: TextStyle(
                                  color: const Color(0xffFF6838),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 250.h,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: event.bids.length,
                        itemBuilder: (ctx, index) {
                          Order order = event.bids.elementAt(index);

                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            minVerticalPadding: 0,
                            horizontalTitleGap: 0,
                            trailing: Text(
                              (order.price * order.quantity).toStringAsFixed(2),
                              style: TextStyle(
                                  color: context.colorScheme.onSurface,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp),
                            ),
                            title: Center(
                              child: Text(
                                order.quantity.toStringAsFixed(2),
                                style: TextStyle(
                                    color: context.colorScheme.onSurface,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp),
                              ),
                            ),
                            leading: Text(
                              order.price.toStringAsFixed(2),
                              style: TextStyle(
                                  color: const Color(0xff25C26E),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp),
                            ),
                          );
                        }),
                  ),
                ],
              ),
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Error: $error'),
            ),
          ],
        ),
      ),
    );
  }
}

class WebsocketDemo extends StatefulWidget {
  const WebsocketDemo({Key? key}) : super(key: key);

  @override
  State<WebsocketDemo> createState() => _WebsocketDemoState();
}

class _WebsocketDemoState extends State<WebsocketDemo> {
  String btcUsdtPrice = "0";
  final channel = IOWebSocketChannel.connect(
      'wss://fstream.binance.com/ws/btcusdt@depth@100ms');

  @override
  void initState() {
    super.initState();
    streamListener();
  }

  streamListener() {
    channel.stream.listen((message) {
      // channel.sink.add('received!');
      // channel.sink.close(status.goingAway);
      Map<String, dynamic> getData = jsonDecode(message);
      OrderBookEvent event = OrderBookEvent.fromJson(getData);
      print(event.asks);
      setState(() {
        // btcUsdtPrice = getData['p'];
      });
      // print(getData['p']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "BTC/USDT Price",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                btcUsdtPrice,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 250, 194, 25),
                    fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
