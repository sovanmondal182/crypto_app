import 'package:crypto_app/providers/coins_provider.dart';
import 'package:crypto_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MarketChart extends StatefulWidget {
  final String id;
  final List<dynamic> chartData;
  MarketChart({Key? key, required this.id, required this.chartData})
      : super(key: key);

  @override
  State<MarketChart> createState() => _MarketChartState();
}

class _MarketChartState extends State<MarketChart> {
  late List<ChartData> _chartData;
  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _trackballBehavior = TrackballBehavior(
        tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
        enable: true,
        activationMode: ActivationMode.singleTap);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeData =
        Provider.of<ThemeProvider>(context, listen: false);

    return SfCartesianChart(
      margin: EdgeInsets.zero,
      borderWidth: 0,
      borderColor: Colors.transparent,
      plotAreaBorderWidth: 0,
      series: <ChartSeries>[
        SplineAreaSeries<ChartData, DateTime>(
          dataSource: _chartData,
          xValueMapper: (ChartData data, _) => data.time,
          yValueMapper: (ChartData data, _) => data.price,
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              (themeData.themeMode == ThemeMode.dark)
                  ? Colors.black
                  : Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ],
      primaryXAxis: DateTimeAxis(
        dateFormat: DateFormat.yMd().add_Hm(),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        isVisible: false,
        borderColor: Colors.transparent,
        borderWidth: 0,
      ),
      primaryYAxis: NumericAxis(
        isVisible: false,
        borderColor: Colors.transparent,
        borderWidth: 0,
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        labelFormat:
            '${Provider.of<CoinsProvider>(context, listen: false).symbol} {value}',
      ),
      trackballBehavior: _trackballBehavior,
      onTrackballPositionChanging: (trackballArgs) {},
    );
  }

  List<ChartData> getChartData() {
    final List<ChartData> chartData = [];

    Provider.of<CoinsProvider>(context, listen: false)
        .fetchChartData(widget.id);
    for (var element in widget.chartData) {
      chartData.add(ChartData(
          DateTime.fromMillisecondsSinceEpoch(element[0]), element[1]));
    }

    return chartData;
  }
}

class ChartData {
  ChartData(this.time, this.price);
  final DateTime time;
  final double price;
}
