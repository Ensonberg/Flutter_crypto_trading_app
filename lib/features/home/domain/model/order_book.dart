class OrderBookEvent {
  final String eventType;
  final DateTime eventTime;
  final String symbol;
  final int firstUpdateId;
  final int finalUpdateId;
  final List<Order> bids;
  final List<Order> asks;

  OrderBookEvent({
    required this.eventType,
    required this.eventTime,
    required this.symbol,
    required this.firstUpdateId,
    required this.finalUpdateId,
    required this.bids,
    required this.asks,
  });

  factory OrderBookEvent.fromJson(Map<String, dynamic> json) {
    var bidsFromJson = json['b'] as List;
    var asksFromJson = json['a'] as List;

    List<Order> bidsList = bidsFromJson.map((i) => Order.fromList(i)).toList();
    List<Order> asksList = asksFromJson.map((i) => Order.fromList(i)).toList();

    return OrderBookEvent(
      eventType: json['e'],
      eventTime: DateTime.fromMillisecondsSinceEpoch(json['E']),
      symbol: json['s'],
      firstUpdateId: json['U'],
      finalUpdateId: json['u'],
      bids: bidsList,
      asks: asksList,
    );
  }

  Map<String, dynamic> toJson() {
    List<List<dynamic>> bidsList = bids.map((order) => order.toList()).toList();
    List<List<dynamic>> asksList = asks.map((order) => order.toList()).toList();

    return {
      'e': eventType,
      'E': eventTime.millisecondsSinceEpoch,
      's': symbol,
      'U': firstUpdateId,
      'u': finalUpdateId,
      'b': bidsList,
      'a': asksList,
    };
  }
}

class Order {
  final double price;
  final double quantity;

  Order({required this.price, required this.quantity});

  factory Order.fromList(List<dynamic> data) {
    return Order(
      price: double.parse(data[0]),
      quantity: double.parse(data[1]),
    );
  }

  List<dynamic> toList() {
    return [price.toString(), quantity.toString()];
  }
}
