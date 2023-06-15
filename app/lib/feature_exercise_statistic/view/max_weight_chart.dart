import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../core_view/util/date_time_display_helper.dart';
import '../../themes/workout_app_theme_data.dart';
import '../../util/localization_util.dart';
import '../ui_state/exercise_statistic_ui_state.dart';

class MaxWeightChart extends StatefulWidget {
  const MaxWeightChart({
    super.key,
    required this.monthlyMaxWeightChartData,
  });

  final MonthlyMaxWeightChartData monthlyMaxWeightChartData;

  @override
  State<MaxWeightChart> createState() => _MaxWeightChartState();
}

class _MaxWeightChartState extends State<MaxWeightChart> {
  static const _dataLengthThreshold = 6;

  final showingTooltipOnSpots = <int>[];

  MonthlyMaxWeightChartData get _monthlyMaxWeightChartData =>
      widget.monthlyMaxWeightChartData;

  List<MonthlyMaxWeightData> get _monthlyMaxWeightDataList =>
      _monthlyMaxWeightChartData.monthlyMaxWeightDataList;
  int get _dataLength => _monthlyMaxWeightDataList.length;
  double get _minWeight => _monthlyMaxWeightChartData.minWeight;
  double get _maxWeight => _monthlyMaxWeightChartData.maxWeight;
  double get _range => _monthlyMaxWeightChartData.range;
  bool get _hasData => _monthlyMaxWeightChartData.hasData;

  @override
  void initState() {
    if (_hasData) {
      showingTooltipOnSpots.add(_dataLength - 1);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasData == false) {
      return Column(
        children: [
          _title(),
          _emptyView(),
        ],
      );
    }

    return Column(
      children: [
        _title(),
        AspectRatio(
          aspectRatio: 1.85,
          child: _dataLength < _dataLengthThreshold
              ? LineChart(
                  mainData(),
                )
              : SingleChildScrollView(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: _dataLength *
                        MediaQuery.of(context).size.width /
                        _dataLengthThreshold,
                    child: LineChart(
                      mainData(),
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _title() {
    return Text(
      LocalizationUtil.localize(context).maxWeightChartTitle,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget _emptyView() {
    return AspectRatio(
      aspectRatio: 1.85,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.onSurface),
          borderRadius: WorkoutAppThemeData.exerciseThumbnailBorderRadius,
        ),
        child: Center(
          child: Text(
            LocalizationUtil.localize(context).maxWeightChartEmptyDescription,
          ),
        ),
      ),
    );
  }

  LineChartData mainData() {
    final lineBarsData = [
      LineChartBarData(
        showingIndicators: showingTooltipOnSpots,
        color: Theme.of(context).colorScheme.secondaryContainer,
        spots: _monthlyMaxWeightDataList
            .mapIndexed((index, monthlyMaxWeightData) =>
                FlSpot(index.toDouble(), monthlyMaxWeightData.totalWeight))
            .toList(growable: false),
        isCurved: false,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          getDotPainter: _getDotPainter,
        ),
      ),
    ];

    final tooltipsOnBar = lineBarsData[0];

    return LineChartData(
      minX: 0,
      maxX: _dataLength.toDouble(),
      minY: _getMinY(),
      maxY: _getMaxY(),
      titlesData: FlTitlesData(
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 35,
            interval: 1,
            getTitlesWidget: _bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 15,
            getTitlesWidget: (_, __) => const SizedBox(),
          ),
        ),
      ),
      gridData: FlGridData(
        checkToShowVerticalLine: (_) => false,
      ),
      borderData: FlBorderData(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      showingTooltipIndicators: showingTooltipOnSpots.map((index) {
        return ShowingTooltipIndicators([
          LineBarSpot(
            tooltipsOnBar,
            lineBarsData.indexOf(tooltipsOnBar),
            tooltipsOnBar.spots[index],
          ),
        ]);
      }).toList(),
      lineBarsData: lineBarsData,
      lineTouchData: LineTouchData(
        handleBuiltInTouches: false,
        touchCallback: _touchCallback,
        touchTooltipData: LineTouchTooltipData(
          tooltipMargin: 20,
          tooltipPadding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 2,
          ),
          tooltipBgColor: Theme.of(context).colorScheme.inverseSurface,
          getTooltipItems: _lineTooltipItem,
        ),
      ),
    );
  }

  double _getMinY() {
    if (_minWeight == _maxWeight) {
      return _minWeight - 1;
    }

    return _minWeight - _range / 2;
  }

  double _getMaxY() {
    if (_minWeight == _maxWeight) {
      return _maxWeight + 1;
    }

    return _maxWeight + _range / 2;
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    final String text;
    final index = value.toInt();
    if (index < _dataLength) {
      final data = _monthlyMaxWeightDataList[index];
      text = "${data.year}\n${data.month.toMonthString()}";
    } else {
      text = "";
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall,
        textAlign: TextAlign.center,
      ),
    );
  }

  FlDotPainter _getDotPainter(
    FlSpot spot,
    double xPercentage,
    LineChartBarData bar,
    int index, {
    double? size,
  }) {
    return FlDotCirclePainter(
      radius: size,
      color: Theme.of(context).colorScheme.primary,
      strokeColor: Theme.of(context).colorScheme.secondary,
    );
  }

  void _touchCallback(FlTouchEvent event, LineTouchResponse? response) {
    if (response == null || response.lineBarSpots == null) {
      return;
    }
    if (event is FlTapUpEvent) {
      final spotIndex = response.lineBarSpots!.first.spotIndex;
      setState(() {
        if (showingTooltipOnSpots.contains(spotIndex)) {
          showingTooltipOnSpots.remove(spotIndex);
        } else {
          showingTooltipOnSpots.add(spotIndex);
        }
      });
    }
  }

  List<LineTooltipItem> _lineTooltipItem(List<LineBarSpot> touchedSpots) {
    return touchedSpots.map((LineBarSpot touchedSpot) {
      return LineTooltipItem(
        touchedSpot.y.toString(),
        Theme.of(context).textTheme.labelMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onInverseSurface,
            ),
      );
    }).toList();
  }
}
