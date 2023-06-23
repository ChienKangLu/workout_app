import 'package:flutter/material.dart';

import '../../themes/workout_app_theme_data.dart';
import '../../util/localization_util.dart';

class WaterShortcutList extends StatefulWidget {
  const WaterShortcutList({
    super.key,
    required this.onItemTap,
  });

  final void Function(double?) onItemTap;

  @override
  State<WaterShortcutList> createState() => _WaterShortcutListState();
}

class _WaterShortcutListState extends State<WaterShortcutList> {
  static const _volumeList = [350, 500, 700];

  void Function(double?) get _onItemTap => widget.onItemTap;

  @override
  Widget build(BuildContext context) {
    final itemCount = _volumeList.length + 1;

    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (content, index) {
          final isLast = index == itemCount - 1;
          final volume = isLast ? null : _volumeList[index];
          final text = isLast
              ? LocalizationUtil.localize(context).waterSelectionOtherTitle
              : "${volume}ml";

          return WaterShortcutItem(
            text: text,
            volume: volume?.toDouble(),
            onItemTap: _onItemTap,
          );
        },
      ),
    );
  }
}

class WaterShortcutItem extends StatelessWidget {
  const WaterShortcutItem({
    super.key,
    required this.text,
    required this.volume,
    required this.onItemTap,
  });

  final String text;
  final double? volume;
  final void Function(double?) onItemTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: WorkoutAppThemeData.pageMargin),
      child: FilledButton.tonal(
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        onPressed: () => onItemTap(volume),
      ),
    );
  }
}
