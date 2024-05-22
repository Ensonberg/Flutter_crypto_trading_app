import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ravenpay_assessment/root_app.dart';
import 'package:web_socket_channel/io.dart';

void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProviderScope(child: RootApp())));
}
