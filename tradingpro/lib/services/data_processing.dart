import 'dart:isolate';
import '../model/market_data.dart';
import 'algorithmic_trading_service.dart';
import 'trading_service.dart';

void processMarketData(SendPort sendPort) {
  final receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);

  receivePort.listen((message) {
    final data = message[0] as List<dynamic>;
    final algorithmicTradingService = message[1] as TradingStrategy;
    final tradingService = message[2] as TradingService;
    final responseSendPort = message[3] as SendPort;

    final marketDataList = data.map((json) => MarketData.fromJson(json)).toList();

    for (var marketData in marketDataList) {
      algorithmicTradingService.evaluateAndPlaceOrder(marketData, tradingService);
    }

    responseSendPort.send(marketDataList);
  });
}
