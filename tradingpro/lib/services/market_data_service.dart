import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../model/market_data.dart';
import 'data_processing.dart';
import 'trading_service.dart';
import 'algorithmic_trading_service.dart';
import 'real_time_data_handler.dart';
import 'dart:convert';
import 'dart:isolate';



//
// class MarketDataService {
//   final WebSocketChannel channel = WebSocketChannel.connect(Uri.parse('ws://localhost:8080'));
//   final TradingService tradingService;
//   final TradingStrategy algorithmicTradingService;
//   final RealTimeDataHandler realTimeDataHandler = RealTimeDataHandler();
//   late Isolate _isolate;
//   late SendPort _sendPort;
//
//   MarketDataService(this.tradingService, this.algorithmicTradingService) {
//     _init();
//   }
//
//   void _init() async {
//     final receivePort = ReceivePort();
//     _isolate = await Isolate.spawn(processMarketData, receivePort.sendPort);
//     _sendPort = await receivePort.first;
//   }
//
//   Stream<List<MarketData>> get marketDataStream async* {
//     await for (var data in channel.stream) {
//       final List<dynamic> jsonList = json.decode(data);
//
//       final response = ReceivePort();
//       _sendPort.send([jsonList, algorithmicTradingService, tradingService, response.sendPort]);
//
//       final processedData = await response.first;
//       yield List<MarketData>.from(processedData as List);
//     }
//   }
// }



class MarketDataService {
  final WebSocketChannel channel = WebSocketChannel.connect(Uri.parse('ws://localhost:8080'));
  final TradingService tradingService;
  final TradingStrategy algorithmicTradingService;
  final RealTimeDataHandler realTimeDataHandler = RealTimeDataHandler();

  MarketDataService(this.tradingService, this.algorithmicTradingService) {
    _init();
  }

  void _init() {
    realTimeDataHandler.connectWebSocket();
  }

  Stream<List<MarketData>> get marketDataStream => realTimeDataHandler.dataStream.map((data) {
    final List<dynamic> jsonList = json.decode(data);
    final marketDataList = jsonList.map((json) => MarketData.fromJson(json)).toList();

    for (var marketData in marketDataList) {
      algorithmicTradingService.evaluateAndPlaceOrder(marketData, tradingService);
    }

    return marketDataList;
  });
}



