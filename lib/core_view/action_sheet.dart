import 'package:flutter/material.dart';

import '../util/localization_util.dart';

class ActionSheet extends StatelessWidget {
  const ActionSheet({
    Key? key,
    required this.hasStartItem,
    required this.hasAddExerciseItm,
    required this.hasFinishItemItem,
    required this.onStartItemClicked,
    required this.onAddExerciseItemClicked,
    required this.onFinishItemClicked,
  }) : super(key: key);

  final bool hasStartItem;
  final bool hasAddExerciseItm;
  final bool hasFinishItemItem;

  final void Function() onStartItemClicked;
  final void Function() onAddExerciseItemClicked;
  final void Function() onFinishItemClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (hasStartItem)
              ActionItem(
                text: LocalizationUtil.localize(context).actionItemStart,
                onTap: onStartItemClicked,
              ),
            if (hasAddExerciseItm)
              ActionItem(
                text: LocalizationUtil.localize(context).actionItemAddExercise,
                onTap: onAddExerciseItemClicked,
              ),
            if (hasFinishItemItem)
              ActionItem(
                text: LocalizationUtil.localize(context).actionItemFinish,
                onTap: onFinishItemClicked,
              ),
          ],
        ),
      ),
    );
  }
}

class ActionItem extends StatelessWidget {
  const ActionItem({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      ),
    );
  }
}

void showActionSheet({
  required BuildContext context,
  required WidgetBuilder builder,
}) =>
    showModalBottomSheet(
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
