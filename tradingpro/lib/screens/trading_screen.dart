import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../model/order.dart';
import '../viewmodels/trading_viewmodel.dart';

class TradingScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final symbolController = useTextEditingController();
    final priceController = useTextEditingController();
    final quantityController = useTextEditingController();

    void handleOrder(bool isBuy) {
      final order = Order(
        symbol: symbolController.text,
        price: double.parse(priceController.text),
        quantity: int.parse(quantityController.text),
        isBuy: isBuy,
      );
      ref.read(ordersProvider.notifier).placeOrder(order);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Trading"),
      //  backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: symbolController,
              decoration: InputDecoration(
                labelText: "Symbol",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                labelText: "Price",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(
                labelText: "Quantity",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => handleOrder(true),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Background color
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  child: Text("Buy"),
                ),
                ElevatedButton(
                  onPressed: () => handleOrder(false),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Background color
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  child: Text("Sell"),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: Consumer(
                builder: (context, watch, child) {
                  final orders = ref.watch(ordersProvider);
                  return ListView.builder(
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
