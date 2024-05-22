import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:interactive_chart/interactive_chart.dart';
import 'package:ravenpay_assessment/features/home/domain/infrastructure/market_data_repository_impl.dart';
import 'package:ravenpay_assessment/features/home/domain/model/kline_data.dart';

class HomeController extends ChangeNotifier {
  final ChangeNotifierProviderRef ref;
  HomeController(this.ref);
  List<KlineData> list = [];
  List<CandleData> data = [];
  bool isLoading = false;
  Future<void> fetchChartData({
    required String symbol,
    required String interval,
    required int limit,
  }) async {
    list.clear();
    data.clear();
    isLoading = true;
    notifyListeners();
    list = await ref
        .watch(marketRepositoryProvider)
        .getKlineData(symbol: symbol, interval: interval, limit: limit);
    Future.forEach(list, (element) {
      data.add(CandleData(
        timestamp: element.closeTime - element.openTime,
        open: element.open,
        high: element.high,
        low: element.low,
        close: element.close,
        volume: double.parse(element.volume),
      ));
    });
    isLoading = false;
    notifyListeners();
  }
}

final homeProvider =
    ChangeNotifierProvider<HomeController>((ref) => HomeController(ref));
