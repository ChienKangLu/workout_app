import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../core_view/action_bottom_sheet.dart';
import '../core_view/ui_mode.dart';
import '../core_view/ui_mode_view_model.dart';
import '../core_view/util/sheet_util.dart';
import '../feature_exercise_statistic/exercise_statistic_page.dart';
import '../util/localization_util.dart';
import 'setting_exercise_view_model.dart';
import 'ui_state/exercise_option_list_ui_state.dart';
import 'view/create_exercise_dialog.dart';
import 'view/edit_exercise_dialog.dart';
import 'view/exercise_option_list.dart';
import 'view/setting_exercise_page_app_bar.dart';

class SettingExercisePage extends StatefulWidget {
  static const routeName = "/setting_exercise_page";

  const SettingExercisePage({Key? key}) : super(key: key);

  @override
  State<SettingExercisePage> createState() => _SettingExercisePageState();
}

class _SettingExercisePageState extends State<SettingExercisePage> {
  late final SettingExerciseViewModel _model;
  late final UiModeViewModel _uiModeViewModel;

  @override
  void initState() {
    _model = SettingExerciseViewModel();
    _uiModeViewModel = UiModeViewModel();

    initViewModels();

    super.initState();
  }

  @override
  void dispose() {
    _model.release();
    _uiModeViewModel.dispose();
    super.dispose();
  }

  Future<void> initViewModels() async {
    await _model.init();
    await _uiModeViewModel.init();
  }

  void _onAppBarCloseButtonClicked() {
    _model.unselectAll();
    _uiModeViewModel.switchTo(UiMode.normal);
  }

  void _onAppBarDeleteButtonClicked() async {
    await _model.deleteSelectedExerciseOptions();
    _uiModeViewModel.switchTo(UiMode.normal);
  }

  void _onNewExercise() async {
    final exerciseName = await showDialog<String>(
      context: context,
      builder: (context) => ChangeNotifierProvider.value(
        value: _model,
        child: const CreateExerciseDialog(),
      ),
    );

    if (exerciseName == null) {
      return;
    }

    await _model.createExercise(exerciseName);
  }

  void _onItemClick(ExerciseOption exerciseOption) {
    _model.select(exerciseOption);
    HapticFeedback.selectionClick();

    final selectedWorkoutCount = _model.selectedItemCount;
    if (selectedWorkoutCount == 0) {
      _uiModeViewModel.switchTo(UiMode.normal);
    }
  }

  void _onItemLongClick(ExerciseOption exerciseOption) {
    final uiMode = _uiModeViewModel.uiMode;
    if (uiMode == UiMode.edit) {
      return;
    }

    _model.select(exerciseOption);
    _uiModeViewModel.switchTo(UiMode.edit);
    HapticFeedback.selectionClick();
  }

  void _onMoreItemClick(ExerciseOption exerciseOption) {
    SheetUtil.showSheet(
      context: context,
      builder: (context) => ActionBottomSheet(
        actionItems: [
          ActionItem(
            title: LocalizationUtil.localize(context).actionItemStatistic,
            onItemClicked: () => _onStatisticButtonClicked(exerciseOption.exerciseId,),
          ),
          ActionItem(
            title: LocalizationUtil.localize(context).actionItemRename,
            onItemClicked: () => _onRenameItemClicked(exerciseOption),
          ),
          ActionItem(
            title: LocalizationUtil.localize(context).actionItemDelete,
            onItemClicked: () => _onDeleteItemClicked(exerciseOption),
          ),
        ],
      ),
    );
  }

  void _onStatisticButtonClicked(int exerciseId) async {
    Navigator.of(context).pop();
    _openExerciseStatisticPage(exerciseId);
  }

  void _openExerciseStatisticPage(int exerciseId) async {
    await Navigator.pushNamed(
      context,
      ExerciseStatisticPage.routeName,
      arguments: exerciseId,
    );
  }

  void _onRenameItemClicked(ExerciseOption exerciseOption) async {
    Navigator.pop(context);

    final exerciseName = await showDialog<String>(
      context: context,
      builder: (context) => ChangeNotifierProvider.value(
        value: _model,
        child: EditExerciseDialog(
          text: exerciseOption.name,
        ),
      ),
    );

    if (exerciseName == null) {
      return;
    }

    await _model.updateExercise(
      exerciseId: exerciseOption.exerciseId,
      name: exerciseName,
    );
  }

  void _onDeleteItemClicked(ExerciseOption exerciseOption) async {
    Navigator.pop(context);

    await _model.deleteExerciseOption([exerciseOption.exerciseId]);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _model),
        ChangeNotifierProvider.value(value: _uiModeViewModel),
      ],
      child: Scaffold(
        appBar: SettingExercisePageAppBar(
          onCloseButtonClicked: _onAppBarCloseButtonClicked,
          onDeleteButtonClicked: _onAppBarDeleteButtonClicked,
        ),
        body: ExerciseOptionList(
          onNewExercise: _onNewExercise,
          onItemClick: _onItemClick,
          onItemLongClick: _onItemLongClick,
          onMoreItemClick: _onMoreItemClick,
        ),
      ),
    );
  }
}
