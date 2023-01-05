import 'package:coinup/providers/coins_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MarketChart extends StatefulWidget {
  final int days;
  final String id;
  final List<dynamic> chartData;
  const MarketChart(
      {Key? key, required this.id, required this.chartData, required this.days})
      : super(key: key);

  @override
  State<MarketChart> createState() => _MarketChartState();
}

class _MarketChartState extends State<MarketChart> {
  late List<ChartData> _chartData;
  late TrackballBehavior _trackballBehavior;
  late String currency =
      Provider.of<CoinsProvider>(context, listen: false).currency;

  @override
  void initState() {
    _chartData = getChartData();
    _trackballBehavior = TrackballBehavior(
        tooltipSettings: const InteractiveTooltip(
            canShowMarker: false, format: 'point.y • point.x'),
        enable: true,
        activationMode: ActivationMode.singleTap);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      margin: EdgeInsets.zero,
      borderWidth: 0,
      borderColor: Colors.transparent,
      plotAreaBorderWidth: 0,
      series: <ChartSeries>[
        SplineSeries<ChartData, DateTime>(
          color: const Color(0xff4D64CF),
          dataSource: _chartData,
          xValueMapper: (ChartData data, _) => data.time,
          yValueMapper: (ChartData data, _) => data.price,
        )
      ],
      primaryXAxis: DateTimeAxis(
        dateFormat: widget.days > 30
            ? DateFormat('d MMM, y')
            : DateFormat('d MMM,').add_jm(),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        isVisible: false,
        borderColor: Colors.transparent,
        borderWidth: 0,
      ),
      primaryYAxis: NumericAxis(
        numberFormat: NumberFormat.currency(
          name: currency,
          decimalDigits: 4,
          symbol: Provider.of<CoinsProvider>(context, listen: false).symbol,
        ),
        isVisible: false,
        borderColor: Colors.transparent,
        borderWidth: 0,
        edgeLabelPlacement: EdgeLabelPlacement.shift,
      ),
      trackballBehavior: _trackballBehavior,
      onTrackballPositionChanging: (trackballArgs) {},
    );
  }

  List<ChartData> getChartData() {
    final List<ChartData> chartData = [];

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
