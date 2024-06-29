import '../model/order.dart';

class TradingService {
  final List<Order> _orders = [];

  void placeOrder(Order order) {
    _orders.add(order);
  }

  List<Order> get orders => _orders;
}
