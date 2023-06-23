abstract class WaterUiState {
  WaterUiState();

  factory WaterUiState.loading() => WaterLoadingUiState();

  factory WaterUiState.success(WaterData waterData) =>
      WaterSuccessUiState(waterData);

  factory WaterUiState.error() => WaterErrorUiState();

  T run<T>({
    required T Function() onLoading,
    required T Function(WaterSuccessUiState) onSuccess,
    required T Function() onError,
  }) {
    if (this is WaterLoadingUiState) {
      return onLoading();
    } else if (this is WaterSuccessUiState) {
      return onSuccess(this as WaterSuccessUiState);
    } else {
      return onError();
    }
  }
}

class WaterLoadingUiState extends WaterUiState {
  static final WaterLoadingUiState _instance = WaterLoadingUiState._internal();

  factory WaterLoadingUiState() {
    return _instance;
  }

  WaterLoadingUiState._internal();
}

class WaterSuccessUiState extends WaterUiState {
  WaterSuccessUiState(this.waterData);

  final WaterData waterData;
}

class WaterErrorUiState extends WaterUiState {
  static final WaterErrorUiState _instance = WaterErrorUiState._internal();

  factory WaterErrorUiState() {
    return _instance;
  }

  WaterErrorUiState._internal();
}

class WaterData {
  WaterData({
    required this.goal,
    required this.total,
    required this.waterLogDataList,
  });

  final double? goal;
  final double? total;
  final List<WaterLogData> waterLogDataList;
}

class WaterLogData {
  WaterLogData({
    required this.id,
    required this.time,
    required this.volume,
  });

  final int id;
  final String time;
  final double volume;
}
