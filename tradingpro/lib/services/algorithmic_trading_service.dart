import '../model/market_data.dart';
import '../model/order.dart';
import 'trading_service.dart';

abstract class TradingStrategy {
  void evaluateAndPlaceOrder(MarketData data, TradingService tradingService);
}
class AlgorithmicTradingService extends TradingStrategy{
  double? highestPrice;
  double? lowestPrice;

  void evaluateAndPlaceOrder(MarketData data, TradingService tradingService) {
    if (highestPrice == null || data.price > highestPrice!) {
      highestPrice = data.price;
    }

    if (lowestPrice == null || data.price < lowestPrice!) {
      lowestPrice = data.price;
    }

    if (highestPrice != null && data.price <= highestPrice! * 0.95) {
      tradingService.placeOrder(Order(symbol: data.symbol, price: data.price, quantity: 1, isBuy: true));
      highestPrice = data.price;
    }

    if (lowestPrice != null && data.price >= lowestPrice! * 1.05) {
      tradingService.placeOrder(Order(symbol: data.symbol, price: data.price, quantity: 1, isBuy: false));
      lowestPrice = data.price;
    }
  }
}
