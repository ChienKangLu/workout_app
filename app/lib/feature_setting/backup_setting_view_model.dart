import 'dart:async';
import 'dart:io';

import '../core_view/view_model.dart';
import '../port/model/port_file.dart';
import '../repository/repository_manager.dart';
import 'ui_state/backup_setting_ui_state.dart';
import 'ui_state/file_picker_ui_state.dart';

class BackupSettingViewModel extends ViewModel {
  static const _tag = "BackupSettingViewModel";
  static const _backupFolder = "WorkoutEasy";

  final _googleRepository = RepositoryManager.instance.googleRepository;
  final _databaseRepository = RepositoryManager.instance.databaseRepository;

  BackupSettingUiState _backupSettingUiState = BackupSettingUiState.loading();
  BackupSettingUiState get backupSettingUiState => _backupSettingUiState;

  FilePickerUiState _filePickerUiState = FilePickerUiState.loading();
  FilePickerUiState get filePickerUiState => _filePickerUiState;

  @override
  Future<void> init() async {
    await super.init();
    await _updateBackupSettingUiState();
    stateChange();
  }

  @override
  Future<void> reload() async {
    if (_backupSettingUiState is! BackupSettingLoadingUiState) {
      _backupSettingUiState = BackupSettingUiState.loading();
      stateChange();
    }

    await _updateBackupSettingUiState();
    stateChange();
  }

  Future<void> _updateBackupSettingUiState() async {
    _backupSettingUiState = BackupSettingUiState.success(
      BackupSetting(),
    );
  }

  Future<void> _updateFilePickerUiState(List<PortFile> portFiles) async {
    _filePickerUiState = FilePickerUiState.success(portFiles
        .map(
          (portFile) => FileItem(
            id: portFile.id,
            name: portFile.name ?? "",
          ),
        )
        .toList());
  }

  Future<bool> uploadBackup() {
    return _googleRepository.uploadFile(
      _backupFolder,
      File(_databaseRepository.dbPath),
    );
  }

  Future<void> fetchBackupFileList() async {
    if (_filePickerUiState is! FilePickerLoadingUiState) {
      _filePickerUiState = FilePickerUiState.loading();
      stateChange();
    }

    final portFiles = await _googleRepository.getFileList(_backupFolder);
    await _updateFilePickerUiState(portFiles);
    stateChange();
  }

  Future<bool> restoreBackup(FileItem fileItem) async {
    final backup = await _googleRepository.download(
      PortFile(fileItem.id, fileItem.name),
    );

    if (backup == null || backup.existsSync() != true) {
      return false;
    }

    await _databaseRepository.restoreBackup(backup);

    await backup.delete();

    return true;
  }
}
