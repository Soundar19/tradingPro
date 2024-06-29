import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../services/trading_service.dart';
import '../model/order.dart';

final tradingProvider = Provider((ref) => TradingService());

final ordersProvider = StateNotifierProvider<OrdersNotifier, List<Order>>((ref) {
  final tradingService = ref.watch(tradingProvider);
  return OrdersNotifier(tradingService);
});

class OrdersNotifier extends StateNotifier<List<Order>> {
  OrdersNotifier(this.tradingService) : super(tradingService.orders);

  final TradingService tradingService;

  void placeOrder(Order order) {
    tradingService.placeOrder(order);
    state = List.from(tradingService.orders); // Ensure state is updated correctly
  }
}
