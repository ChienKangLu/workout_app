import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core_view/action_bottom_sheet.dart';
import '../core_view/empty_view.dart';
import '../core_view/util/sheet_util.dart';
import '../util/assets.dart';
import '../util/localization_util.dart';
import 'view/edit_water_dialog.dart';
import 'view/water_log_list.dart';
import 'water_view_model.dart';

class WaterLogPage extends StatefulWidget {
  const WaterLogPage({super.key});

  @override
  State<WaterLogPage> createState() => _WaterLogPageState();
}

class _WaterLogPageState extends State<WaterLogPage> {
  WaterViewModel get _viewModel =>
      Provider.of<WaterViewModel>(context, listen: false);

  void _onMoreButtonClicked(int id, double volume) {
    SheetUtil.showSheet(
      context: context,
      builder: (context) => ActionBottomSheet(
        actionItems: [
          ActionItem(
            title: LocalizationUtil.localize(context).actionItemEdit,
            onItemClicked: () => _onEditItemClicked(id, volume),
          ),
          ActionItem(
            title: LocalizationUtil.localize(context).actionItemDelete,
            onItemClicked: () => _onDeleteItemClicked(id),
          ),
        ],
      ),
    );
  }

  void _onEditItemClicked(int id, double volume) async {
    Navigator.pop(context);

    final update = await showDialog<String>(
      context: context,
      builder: (context) => EditWaterDialog(
        text: volume.toString(),
      ),
    );

    if (update == null) {
      return;
    }
    final updatedVolume = double.parse(update);
    if (updatedVolume == volume) {
      return;
    }

    await _viewModel.updateLog(id, double.parse(update));
  }

  void _onDeleteItemClicked(int id) {
    Navigator.pop(context);

    _viewModel.deleteLog(id);
  }

  @override
  Widget build(BuildContext context) {
    final waterUiState = context.watch<WaterViewModel>().waterUiState;

    return waterUiState.run(
      onLoading: () => const SizedBox(),
      onSuccess: (success) {
        final waterData = success.waterData;
        final waterLogDataList = waterData.waterLogDataList;
        if (waterLogDataList.isEmpty) {
          return EmptyView(
            assetName: Assets.waterLogEmpty,
            header: LocalizationUtil.localize(context).waterLogEmptyHeader,
            body: LocalizationUtil.localize(context).waterLogEmptyBody,
            buttonTitle: LocalizationUtil.localize(context).waterDrinkButton,
            onAction: () {
              DefaultTabController.of(context).animateTo(0);
            },
          );
        }

        return WaterLogList(
          waterLogDataList: waterData.waterLogDataList,
          onMoreButtonClicked: _onMoreButtonClicked,
        );
      },
      onError: () => const SizedBox(),
    );
  }
}
