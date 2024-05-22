import 'package:ravenpay_assessment/features/home/domain/model/kline_data.dart';

abstract class MarketDataRepository {
  Future<List<KlineData>> getKlineData(
      {required String symbol, required String interval, required int limit});
}
