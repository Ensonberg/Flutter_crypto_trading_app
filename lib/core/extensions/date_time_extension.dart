import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// Extension that allows to substitute [DateTime.now] with a testable function
extension DateTimeX on DateTime {
  /// Allows copying [DateTime] with an arbitrary shift in time
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  /// Default [DateTime] format to be used on the UI
  String defaultString() {
    return DateFormat.yMMMd().format(this);
  }

  static DateTime? _customTime;

  /// Method that allows to get current [DateTime] in runtime or custom [DateTime] in tests
  static DateTime get current {
    return _customTime ?? DateTime.now();
  }

  @visibleForTesting
  static set customTime(DateTime? customTime) {
    _customTime = customTime;
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

extension DurationExtensions on Duration {
  String formatDuration() {
    int seconds = inSeconds;
    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;
    String strDigits(int n) => n.toString().padLeft(2, '0');

    final List<String> tokens = [];
    if (days != 0) {
      tokens.add('${days}d');
    }
    if (tokens.isNotEmpty || hours != 0) {
      tokens.add('${hours}');
    }

    tokens.add(strDigits(minutes));

    tokens.add(':${strDigits(seconds)}');

    return tokens.join('');
  }
}

extension extString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp = RegExp(r"^[a-zA-Z]+$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z]).{6,}$');
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull {
    return this != null;
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
    return phoneRegExp.hasMatch(this);
  }
}
