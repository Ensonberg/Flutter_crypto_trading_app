class KlineData {
  int openTime;
  double open;
  double high;
  double low;
  double close;
  String volume;
  int closeTime;
  double baseAssetVolume;
  int numberOfTrades;
  double takerBuyVolume;
  double takerBuyBaseAssetVolume;
  int ignore;

  KlineData({
    required this.openTime,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
    required this.closeTime,
    required this.baseAssetVolume,
    required this.numberOfTrades,
    required this.takerBuyVolume,
    required this.takerBuyBaseAssetVolume,
    required this.ignore,
  });

  factory KlineData.fromList(List<dynamic> data) {
    return KlineData(
      openTime: data[0],
      open: double.parse(data[1]),
      high: double.parse(data[2]),
      low: double.parse(data[3]),
      close: double.parse(data[4]),
      volume: data[5],
      closeTime: data[6],
      baseAssetVolume: double.parse(data[7]),
      numberOfTrades: data[8],
      takerBuyVolume: double.parse(data[9]),
      takerBuyBaseAssetVolume: double.parse(data[10]),
      ignore: int.parse(data[11]),
    );
  }

  factory KlineData.fromJson(Map<String, dynamic> json) {
    return KlineData(
      openTime: json['openTime'],
      open: json['open'].toDouble(),
      high: json['high'].toDouble(),
      low: json['low'].toDouble(),
      close: json['close'].toDouble(),
      volume: json['volume'],
      closeTime: json['closeTime'],
      baseAssetVolume: json['baseAssetVolume'].toDouble(),
      numberOfTrades: json['numberOfTrades'],
      takerBuyVolume: json['takerBuyVolume'].toDouble(),
      takerBuyBaseAssetVolume: json['takerBuyBaseAssetVolume'].toDouble(),
      ignore: json['ignore'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'openTime': openTime,
      'open': open,
      'high': high,
      'low': low,
      'close': close,
      'volume': volume,
      'closeTime': closeTime,
      'baseAssetVolume': baseAssetVolume,
      'numberOfTrades': numberOfTrades,
      'takerBuyVolume': takerBuyVolume,
      'takerBuyBaseAssetVolume': takerBuyBaseAssetVolume,
      'ignore': ignore,
    };
  }
}
