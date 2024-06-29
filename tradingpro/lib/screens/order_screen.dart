import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../viewmodels/trading_viewmodel.dart';

class OrderScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(ordersProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
       // backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: orders.isEmpty
            ? Center(child: Text("No orders found", style: TextStyle(fontSize: 18)))
            : ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Icon(
                  order.isBuy ? Icons.arrow_upward : Icons.arrow_downward,
                  color: order.isBuy ? Colors.green : Colors.red,
                ),
                title: Text(
                  "${order.isBuy ? "Buy" : "Sell"} ${order.symbol}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: order.isBuy ? Colors.green : Colors.red,
                  ),
                ),
                subtitle: Text(
                  "${order.quantity} @ \$${order.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
