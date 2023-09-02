import 'dart:async';

import '../core_view/util/date_time_display_helper.dart';
import '../core_view/view_model.dart';
import '../use_case/water_use_case.dart';
import 'ui_state/water_ui_state.dart';

class WaterViewModel extends ViewModel {
  static const _tag = "WaterViewModel";

  WaterViewModel();

  final WaterUseCase _waterUseCase = WaterUseCase();
  StreamSubscription? _waterGoalSubscription;

  WaterUiState _waterUiState = WaterUiState.loading();
  WaterUiState get waterUiState => _waterUiState;

  @override
  Future<void> init() async {
    await super.init();
    _waterGoalSubscription =
        _waterUseCase.observeWaterGoalChange(_onWaterGoalChange);

    await _updateWaterUiState();
    stateChange();
  }

  @override
  void dispose() {
    _waterGoalSubscription?.cancel();

    super.dispose();
  }

  void _onWaterGoalChange() {
    reload();
  }

  @override
  Future<void> reload({
    bool isLongOperation = false,
  }) async {
    if (_waterUiState is! WaterLoadingUiState &&
        isLongOperation) {
      _waterUiState = WaterUiState.loading();
      stateChange();
    }

    await _updateWaterUiState();
    stateChange();
  }

  Future<void> _updateWaterUiState() async {
    final waterGoal = await _waterUseCase.getWaterGoal();
    final waterLogs = await _waterUseCase.getLogsOf(DateTime.now());

    _waterUiState = WaterUiState.success(
      WaterData(
        goal: waterGoal?.volume,
        total: waterLogs.fold<double>(
          0,
          (previousValue, log) => previousValue + log.volume,
        ),
        waterLogDataList: waterLogs
            .map(
              (waterLog) => WaterLogData(
                id: waterLog.id,
                time: DateTimeDisplayHelper.time(waterLog.dateTime),
                volume: waterLog.volume,
              ),
            )
            .toList(growable: false),
      ),
    );
  }

  Future<void> setGoal(double volume) async {
    final result = await _waterUseCase.setGoal(volume);
    if (!result) {
      return;
    }

    await _updateWaterUiState();
    stateChange();
  }

  Future<void> addLog(double volume) async {
    final result = await _waterUseCase.addLog(volume);
    if (!result) {
      return;
    }

    await _updateWaterUiState();
    stateChange();
  }

  Future<void> deleteLog(int id) async {
    final result = await _waterUseCase.deleteLog(id);
    if (!result) {
      return;
    }

    await _updateWaterUiState();
    stateChange();
  }

  Future<void> updateLog(int id, double volume) async {
    final result = await _waterUseCase.updateLog(id, volume);
    if (!result) {
      return;
    }

    await _updateWaterUiState();
    stateChange();
  }
}
