import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntervalNotifier extends StateNotifier<String> {
  IntervalNotifier() : super("1d");

  void updateInterval(String interval) {
    state = interval;
  }
}

final intervalProvider = StateNotifierProvider<IntervalNotifier, String>((ref) {
  return IntervalNotifier();
});
