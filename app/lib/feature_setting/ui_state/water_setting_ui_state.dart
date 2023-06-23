abstract class WaterSettingUiState {
  WaterSettingUiState();

  factory WaterSettingUiState.loading() => WaterSettingLoadingUiState();

  factory WaterSettingUiState.success(WaterSetting waterSetting) =>
      WaterSettingSuccessUiState(waterSetting);

  factory WaterSettingUiState.error() => WaterSettingErrorUiState();

  T run<T>({
    required T Function() onLoading,
    required T Function(WaterSettingSuccessUiState) onSuccess,
    required T Function() onError,
  }) {
    if (this is WaterSettingLoadingUiState) {
      return onLoading();
    } else if (this is WaterSettingSuccessUiState) {
      return onSuccess(this as WaterSettingSuccessUiState);
    } else {
      return onError();
    }
  }
}

class WaterSettingLoadingUiState extends WaterSettingUiState {
  static final WaterSettingLoadingUiState _instance =
      WaterSettingLoadingUiState._internal();

  factory WaterSettingLoadingUiState() {
    return _instance;
  }

  WaterSettingLoadingUiState._internal();
}

class WaterSettingSuccessUiState extends WaterSettingUiState {
  WaterSettingSuccessUiState(this.waterSetting);

  final WaterSetting waterSetting;
}

class WaterSettingErrorUiState extends WaterSettingUiState {
  static final WaterSettingErrorUiState _instance =
      WaterSettingErrorUiState._internal();

  factory WaterSettingErrorUiState() {
    return _instance;
  }

  WaterSettingErrorUiState._internal();
}

class WaterSetting {
  WaterSetting({
    required this.goal,
  });

  final double? goal;
}
