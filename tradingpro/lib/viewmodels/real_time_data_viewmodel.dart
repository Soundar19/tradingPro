import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../model/market_data.dart';
import '../services/real_time_data_handler.dart';
//
// final realTimeDataHandlerProvider = Provider((ref) => RealTimeDataHandler());
//
// final realTimeDataProvider = StreamProvider.autoDispose<List<MarketData>>((ref) {
//   final realTimeDataHandler = ref.watch(realTimeDataHandlerProvider);
//   realTimeDataHandler.startReceivingData();
//
//   const eventChannel = EventChannel('com.example.tradingapp/realtime');
//   return eventChannel.receiveBroadcastStream().map((data) {
//     final List<dynamic> dataList = data as List<dynamic>;
//     return dataList.map((item) => MarketData.fromJson(Map<String, dynamic>.from(item))).toList();
//   });
// });

import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../services/real_time_data_handler.dart';

final realTimeDataHandlerProvider = Provider((ref) => RealTimeDataHandler());
