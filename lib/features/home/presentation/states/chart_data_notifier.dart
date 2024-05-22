import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChartDataNotifier extends StateNotifier<String> {
  ChartDataNotifier() : super("1d");

  void updateInterval(String interval) {
    state = interval;
  }
}

final intervalProvider =
    StateNotifierProvider<ChartDataNotifier, String>((ref) {
  return ChartDataNotifier();
});
