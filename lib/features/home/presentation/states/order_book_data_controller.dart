import 'dart:async';
import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ravenpay_assessment/features/home/domain/model/order_book.dart';
import 'package:web_socket_channel/io.dart';

class ChartDataStreamNotifier extends StreamNotifier<OrderBookEvent> {
  @override
  Stream<OrderBookEvent> build() async* {
    final channel = IOWebSocketChannel.connect(
        'wss://fstream.binance.com/ws/btcusdt@depth');

    // Close the connection when the stream is destroyed
    ref.onDispose(() => channel.sink.close());

    final streamController = StreamController<OrderBookEvent>();

    // Listen to the WebSocket stream and add events to the StreamController
    channel.stream.listen((message) {
      final Map<String, dynamic> getData =
          jsonDecode(message) as Map<String, dynamic>;
      final OrderBookEvent event = OrderBookEvent.fromJson(getData);
      streamController.add(event);
      //print(event.k.o);
    }, onError: (error) {
      streamController.addError(error);
    }, onDone: () {
      streamController.close();
    });

    // Yield the events from the StreamController
    // print(streamController.stream);
    yield* streamController.stream;
  }
}

final orderBookProvider =
    StreamNotifierProvider<ChartDataStreamNotifier, OrderBookEvent>(
        () => ChartDataStreamNotifier());
