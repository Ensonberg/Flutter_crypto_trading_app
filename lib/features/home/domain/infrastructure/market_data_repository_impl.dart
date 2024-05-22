import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ravenpay_assessment/features/home/domain/model/kline_data.dart';
import 'package:ravenpay_assessment/features/home/infrastructure/repository/market_data_repository.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MarketDataRepositoryImpl extends MarketDataRepository {
  final String baseUrl = 'https://api.binance.com';
  @override
  Future<List<KlineData>> getKlineData(
      {required String symbol,
      required String interval,
      required int limit}) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/api/v3/klines?symbol=$symbol&interval=$interval&limit=$limit'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      print(data);
      return data.map((item) => KlineData.fromList(item)).toList();
    } else {
      throw Exception('Failed to load trade data');
    }
  }
}

final marketRepositoryProvider = Provider<MarketDataRepository>((ref) {
  return MarketDataRepositoryImpl();
});
