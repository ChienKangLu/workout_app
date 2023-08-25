abstract class BackupSettingUiState {
  BackupSettingUiState();

  factory BackupSettingUiState.loading() => BackupSettingLoadingUiState();

  factory BackupSettingUiState.success(BackupSetting backupSetting) =>
      BackupSettingSuccessUiState(backupSetting);

  factory BackupSettingUiState.error() => BackupSettingErrorUiState();

  T run<T>({
    required T Function() onLoading,
    required T Function(BackupSettingSuccessUiState) onSuccess,
    required T Function() onError,
  }) {
    if (this is BackupSettingLoadingUiState) {
      return onLoading();
    } else if (this is BackupSettingSuccessUiState) {
      return onSuccess(this as BackupSettingSuccessUiState);
    } else {
      return onError();
    }
  }
}

class BackupSettingLoadingUiState extends BackupSettingUiState {
  static final BackupSettingLoadingUiState _instance =
      BackupSettingLoadingUiState._internal();

  factory BackupSettingLoadingUiState() {
    return _instance;
  }

  BackupSettingLoadingUiState._internal();
}

class BackupSettingSuccessUiState extends BackupSettingUiState {
  BackupSettingSuccessUiState(this.backupSetting);

  final BackupSetting backupSetting;
}

class BackupSettingErrorUiState extends BackupSettingUiState {
  static final BackupSettingErrorUiState _instance =
      BackupSettingErrorUiState._internal();

  factory BackupSettingErrorUiState() {
    return _instance;
  }

  BackupSettingErrorUiState._internal();
}

class BackupSetting {

}
