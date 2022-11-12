import 'package:flutter/material.dart';

import '../util/localization_util.dart';
import 'list_item.dart';

enum ActionType {
  startWorkout,
  finishWorkout,
  addExercise,
}

class ActionSheet extends StatelessWidget {
  const ActionSheet({
    Key? key,
    required this.hasStartItem,
    required this.hasFinishItemItem,
    required this.hasAddExerciseItm,
  }) : super(key: key);

  final bool hasStartItem;
  final bool hasFinishItemItem;
  final bool hasAddExerciseItm;

  void onItemClicked(BuildContext context, ActionType type) {
    Navigator.pop(context, type);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (hasStartItem)
              ListItem(
                text: LocalizationUtil.localize(context).actionItemStart,
                onTap: () => onItemClicked(context, ActionType.startWorkout),
              ),
            if (hasAddExerciseItm)
              ListItem(
                text: LocalizationUtil.localize(context).actionItemAddExercise,
                onTap: () => onItemClicked(context, ActionType.addExercise),
              ),
            if (hasFinishItemItem)
              ListItem(
                text: LocalizationUtil.localize(context).actionItemFinish,
                onTap: () => onItemClicked(context, ActionType.finishWorkout),
              ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

Future<T?> showActionSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
}) =>
    showModalBottomSheet<T>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.zero,
          topLeft: Radius.circular(15),
          bottomRight: Radius.zero,
          topRight: Radius.circular(15),
        ),
      ),
      builder: builder,
    );
