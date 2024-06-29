import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tradingpro/real_time_data_handler.dart';
import 'package:tradingpro/screens/login_screen.dart';
import 'package:tradingpro/screens/market_data_screen.dart';
import 'package:tradingpro/screens/order_screen.dart';
import 'package:tradingpro/screens/trading_screen.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized();
  await Firebase.initializeApp();
  DartPluginRegistrant.ensureInitialized();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trading App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: '/',
      routes: {
           '/': (context) => LoginScreen(),
       // '/': (context) => MarketDataScreen(),
          '/market': (context) => MarketDataScreen(),
        '/trading': (context) => TradingScreen(),
        '/orders': (context) => OrderScreen(),
        //  '/login': (context) => LoginScreen(),
      },
    );
  }
}
