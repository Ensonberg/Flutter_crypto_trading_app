import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ravenpay_assessment/features/home/domain/model/kline_event.dart';
import 'package:ravenpay_assessment/features/home/presentation/states/interval_notifier.dart';
import 'package:web_socket_channel/io.dart';

class PriceStreamNotifier extends StreamNotifier<KlineEvent> {
  @override
  Stream<KlineEvent> build() async* {
    final channel = IOWebSocketChannel.connect(
        'wss://fstream.binance.com/ws/btcusdt@kline_1m');

    // Close the connection when the stream is destroyed
    ref.onDispose(() => channel.sink.close());

    final streamController = StreamController<KlineEvent>();

    // Listen to the WebSocket stream and add events to the StreamController
    channel.stream.listen((message) {
      final Map<String, dynamic> getData =
          jsonDecode(message) as Map<String, dynamic>;
      final KlineEvent event = KlineEvent.fromJson(getData);
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

final priceProvider = StreamNotifierProvider<PriceStreamNotifier, KlineEvent>(
    () => PriceStreamNotifier());
