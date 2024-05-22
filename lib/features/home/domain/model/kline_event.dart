class Kline {
  final int t;
  final int T;
  final String s;
  final String i;
  final int f;
  final int L;
  final String o;
  final String c;
  final String h;
  final String l;
  final String v;
  final int n;
  final bool x;
  final String q;
  final String V;
  final String Q;
  final String B;

  Kline({
    required this.t,
    required this.T,
    required this.s,
    required this.i,
    required this.f,
    required this.L,
    required this.o,
    required this.c,
    required this.h,
    required this.l,
    required this.v,
    required this.n,
    required this.x,
    required this.q,
    required this.V,
    required this.Q,
    required this.B,
  });

  factory Kline.fromJson(Map<String, dynamic> json) {
    return Kline(
      t: json['t'],
      T: json['T'],
      s: json['s'],
      i: json['i'],
      f: json['f'],
      L: json['L'],
      o: json['o'],
      c: json['c'],
      h: json['h'],
      l: json['l'],
      v: json['v'],
      n: json['n'],
      x: json['x'],
      q: json['q'],
      V: json['V'],
      Q: json['Q'],
      B: json['B'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      't': t,
      'T': T,
      's': s,
      'i': i,
      'f': f,
      'L': L,
      'o': o,
      'c': c,
      'h': h,
      'l': l,
      'v': v,
      'n': n,
      'x': x,
      'q': q,
      'V': V,
      'Q': Q,
      'B': B,
    };
  }
}

class KlineEvent {
  final String e;
  final int E;
  final String s;
  final Kline k;

  KlineEvent({
    required this.e,
    required this.E,
    required this.s,
    required this.k,
  });

  factory KlineEvent.fromJson(Map<String, dynamic> json) {
    return KlineEvent(
      e: json['e'],
      E: json['E'],
      s: json['s'],
      k: Kline.fromJson(json['k']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'e': e,
      'E': E,
      's': s,
      'k': k.toJson(),
    };
  }
}
