import '../core_view/view_model.dart';
import '../model/water_goal.dart';
import '../use_case/water_use_case.dart';
import 'ui_state/water_setting_ui_state.dart';

class WaterSettingViewModel extends ViewModel {
  static const _tag = "WaterSettingViewModel";

  WaterSettingViewModel();

  final WaterUseCase _waterUseCase = WaterUseCase();

  WaterSettingUiState _waterSettingUiState = WaterSettingUiState.loading();
  WaterSettingUiState get waterSettingUiState => _waterSettingUiState;

  @override
  Future<void> init() async {
    await super.init();
    await _updateWaterSettingUiState();
    stateChange();
  }

  @override
  Future<void> reload({
    bool isLongOperation = false,
  }) async {
    if (_waterSettingUiState is! WaterSettingLoadingUiState &&
        isLongOperation) {
      _waterSettingUiState = WaterSettingUiState.loading();
      stateChange();
    }

    await _updateWaterSettingUiState();
    stateChange();
  }

  Future<void> _updateWaterSettingUiState() async {
    final waterGoal = await _getWaterGoal();

    _waterSettingUiState = WaterSettingUiState.success(
      WaterSetting(
        goal: waterGoal?.volume,
      ),
    );
  }

  Future<void> setGoal(double volume) async {
    final result = await _waterUseCase.setGoal(volume);
    if (!result) {
      return;
    }

    await _updateWaterSettingUiState();
    stateChange();
  }

  Future<WaterGoal?> _getWaterGoal() async {
    final result = await _waterUseCase.getGoal();
    return result;
  }
}
