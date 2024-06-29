import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../services/market_data_service.dart';
import '../services/trading_service.dart';
import '../services/algorithmic_trading_service.dart';
import 'trading_viewmodel.dart';

final algorithmicTradingProvider = Provider((ref) => AlgorithmicTradingService());

final marketDataProvider = Provider((ref) {
  final tradingService = ref.watch(tradingProvider);
  final algorithmicTradingService = ref.watch(algorithmicTradingProvider);
  return MarketDataService(tradingService, algorithmicTradingService);
});

final marketDataStreamProvider = StreamProvider.autoDispose((ref) {
  final marketDataService = ref.watch(marketDataProvider);
  return marketDataService.marketDataStream;
});
