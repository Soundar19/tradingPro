import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../model/market_data.dart';

class MarketDataGraph extends StatelessWidget {
  final List<MarketData> data;

  MarketDataGraph({required this.data});

  List<FlSpot> _getSampledSpots(List<MarketData> data) {
    int sampleRate = (data.length / 5).ceil(); // Adjust sample rate to show five values
    List<FlSpot> spots = [];

    for (int i = 0; i < data.length; i += sampleRate) {
      spots.add(FlSpot(i.toDouble(), data[i].price));
    }

    return spots;
  }

  List<String> _getSampledLabels(List<MarketData> data) {
    int sampleRate = (data.length / 5).ceil();
    List<String> labels = [];

    for (int i = 0; i < data.length; i += sampleRate) {
      labels.add(data[i].symbol);
    }

    return labels;
  }

  List<double> _getSampledPrices(List<MarketData> data) {
    int sampleRate = (data.length / 5).ceil();
    List<double> prices = [];

    for (int i = 0; i < data.length; i += sampleRate) {
      prices.add(data[i].price);
    }

    return prices;
  }

  @override
  Widget build(BuildContext context) {
    final sampledSpots = _getSampledSpots(data);
    final sampledLabels = _getSampledLabels(data);
    final sampledPrices = _getSampledPrices(data);



    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          leftTitles: SideTitles(
            showTitles: true,
            getTextStyles: (context, value) => const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            margin: 10,
            interval: (sampledPrices.reduce((a, b) => a > b ? a : b) - sampledPrices.reduce((a, b) => a < b ? a : b)) / 4,
            getTitles: (value) {
              final int numberOfYLabels = 5;
              final double minValue = sampledPrices.reduce((a, b) => a < b ? a : b);
              final double maxValue = sampledPrices.reduce((a, b) => a > b ? a : b);
              final double step = (maxValue - minValue) / (numberOfYLabels - 1);

              if (value >= minValue && value <= maxValue && ((value - minValue) % step).abs() < 0.1) {
                return value.toStringAsFixed(2);
              } else {
                return '';
              }
            },
          ),
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (context, value) => const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            margin: 10,
            interval: 1,
            getTitles: (value) {
              int index = value.toInt();
              if (index >= 0 && index < sampledLabels.length) {
                return sampledLabels[index];
              } else {
                return '';
              }
            },
          ),
        ),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: sampledSpots,
            isCurved: true,
           // colors: [Colors.blue],
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}
