import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../viewmodels/market_data_viewmodel.dart';
import 'market_data_graph.dart';
import 'trading_screen.dart';
import 'order_screen.dart';

class MarketDataScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final marketDataAsyncValue = ref.watch(marketDataStreamProvider);

    // Future<void> _logout() async {
    //   await ref.read(authProvider).signOut();
    //   Navigator.pushReplacementNamed(context, '/login');
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text("Market Data"),
      //  backgroundColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.trending_up),
              title: Text('Go to Trading'),
              onTap: () {
                Navigator.pushNamed(context, '/trading');
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('View Orders'),
              onTap: () {
                Navigator.pushNamed(context, '/orders');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
            //  onTap: () => _logout(),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Market Data Overview',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
           //     color: Colors.blueGrey,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              flex: 2,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: marketDataAsyncValue.when(
                    data: (data) => MarketDataGraph(data: data),
                    loading: () => Center(child: CircularProgressIndicator()),
                    error: (e, stack) => Center(child: Text("Error: $e")),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              flex: 3,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: marketDataAsyncValue.when(
                    data: (data) => ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final marketData = data[index];
                        return ListTile(
                          leading: Icon(
                            Icons.show_chart,
                           // color: Colors.blueAccent,
                          ),
                          title: Text(
                            marketData.symbol,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "\$${marketData.price.toStringAsFixed(2)}",
                            style: TextStyle(color: Colors.black54),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                        );
                      },
                    ),
                    loading: () => Center(child: CircularProgressIndicator()),
                    error: (e, stack) => Center(child: Text("Error: $e")),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
