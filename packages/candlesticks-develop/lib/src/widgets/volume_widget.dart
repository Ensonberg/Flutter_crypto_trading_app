import 'package:candlesticks/src/models/candle.dart';
import 'package:flutter/material.dart';
import '../models/candle.dart';

class VolumeWidget extends LeafRenderObjectWidget {
  final List<Candle> candles;
  final int index;
  final double barWidth;
  final double high;
  final Color bullColor;
  final Color bearColor;

  VolumeWidget({
    required this.candles,
    required this.index,
    required this.barWidth,
    required this.high,
    required this.bearColor,
    required this.bullColor,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return VolumeRenderObject(
      candles,
      index,
      barWidth,
      high,
      bearColor,
      bullColor,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderObject renderObject) {
    VolumeRenderObject candlestickRenderObject =
        renderObject as VolumeRenderObject;
    candlestickRenderObject._candles = candles;
    candlestickRenderObject._index = index;
    candlestickRenderObject._barWidth = barWidth;
    candlestickRenderObject._high = high;
    candlestickRenderObject._bearColor = bearColor;
    candlestickRenderObject._bullColor = bullColor;
    candlestickRenderObject.markNeedsPaint();
    super.updateRenderObject(context, renderObject);
  }
}

class VolumeRenderObject extends RenderBox {
  late List<Candle> _candles;
  late int _index;
  late double _barWidth;
  late double _high;
  late Color _bearColor;
  late Color _bullColor;

  VolumeRenderObject(
    List<Candle> candles,
    int index,
    double barWidth,
    double high,
    Color bearColor,
    Color bullColor,
  ) {
    _candles = candles;
    _index = index;
    _barWidth = barWidth;
    _high = high;
    _bearColor = bearColor;
    _bullColor = bullColor;
  }

  /// set size as large as possible
  @override
  void performLayout() {
    size = Size(constraints.maxWidth, constraints.maxHeight);
  }

  /// draws a single candle
  void paintBar(PaintingContext context, Offset offset, int index,
      Candle candle, double range) {
    Color color = candle.isBull ? _bullColor : _bearColor;

    double x = size.width + offset.dx - (index + 0.5) * _barWidth;
    double candleTop = offset.dy + (_high - candle.volume) / range;
    double candleBottom = offset.dy + size.height;
    // Draw the border
    Paint borderPaint = Paint()
      ..color = candle.isBull ? Color(0xff58BD7D) : Color(0xffFF6838)
      ..strokeWidth = _barWidth - 4 // Slightly thicker for border effect
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.fill;

    // Draw vertical border
    context.canvas
        .drawLine(Offset(x, candleTop), Offset(x, candleBottom), borderPaint);

    // Draw top horizontal border
    context.canvas.drawLine(Offset(x - (_barWidth - 4) / 2, candleTop),
        Offset(x + (_barWidth - 4) / 2, candleTop), borderPaint);

    // Draw bottom horizontal border
    context.canvas.drawLine(Offset(x - (_barWidth - 4) / 2, candleBottom),
        Offset(x + (_barWidth - 4) / 2, candleBottom), borderPaint);

    // Draw the actual candle
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = _barWidth - 6 // Original stroke width
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    // Draw vertical candle
    context.canvas
        .drawLine(Offset(x, candleTop), Offset(x, candleBottom), paint);

    // Draw top horizontal candle line
    context.canvas.drawLine(Offset(x - (_barWidth - 6) / 2, candleTop),
        Offset(x + (_barWidth - 6) / 2, candleTop), paint);

    // Draw bottom horizontal candle line
    context.canvas.drawLine(Offset(x - (_barWidth - 6) / 2, candleBottom),
        Offset(x + (_barWidth - 6) / 2, candleBottom), paint);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    double range = (_high) / size.height;
    for (int i = 0; (i + 1) * _barWidth < size.width; i++) {
      if (i + _index >= _candles.length || i + _index < 0) continue;
      var candle = _candles[i + _index];
      paintBar(context, offset, i, candle, range);
    }
    context.canvas.save();
    context.canvas.restore();
  }
}
