import 'package:flutter/material.dart';

import '../../themes/workout_app_theme_data.dart';
import '../ui_state/water_ui_state.dart';

class WaterLogList extends StatelessWidget {
  const WaterLogList({
    super.key,
    required this.waterLogDataList,
    required this.onMoreButtonClicked,
  });

  final List<WaterLogData> waterLogDataList;
  final Function(int, double) onMoreButtonClicked;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: waterLogDataList.length,
      itemBuilder: (content, index) {
        return WaterLogItem(
          data: waterLogDataList[index],
          onMoreButtonClicked: onMoreButtonClicked,
        );
      },
    );
  }
}

class WaterLogItem extends StatelessWidget {
  const WaterLogItem({
    super.key,
    required this.data,
    required this.onMoreButtonClicked,
  });

  final WaterLogData data;
  final Function(int, double) onMoreButtonClicked;

  @override
  Widget build(BuildContext context) {
    final id = data.id;
    final volume = data.volume;

    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: WorkoutAppThemeData.pageMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            data.time,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            "${data.volume.toInt().toString()}ml",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              onMoreButtonClicked(id, volume);
            },
          ),
        ],
      ),
    );
  }
}
