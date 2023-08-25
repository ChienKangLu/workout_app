import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core_view/confirm_dialog.dart';
import '../../util/localization_util.dart';
import '../backup_setting_view_model.dart';
import '../ui_state/file_picker_ui_state.dart';
import 'file_picker_dialog.dart';
import 'loading_dialog.dart';
import 'setting_group_view.dart';
import 'setting_list_tile.dart';

class BackupSettingGroup extends StatefulWidget {
  const BackupSettingGroup({super.key});

  @override
  State<BackupSettingGroup> createState() => _BackupSettingGroupState();
}

class _BackupSettingGroupState extends State<BackupSettingGroup> {
  late final BackupSettingViewModel _model;

  @override
  void initState() {
    _model = BackupSettingViewModel();

    _initViewModels();

    super.initState();
  }

  @override
  void dispose() {
    _model.release();
    super.dispose();
  }

  Future<void> _initViewModels() async {
    await _model.init();
  }

  void _onUploadBackupClicked() {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LoadingDialog(
          inProgressTitle: LocalizationUtil.localize(context)
              .backUpToGoogleDriveInProgressTitle,
          completeTitle: LocalizationUtil.localize(context)
              .backUpToGoogleDriveCompleteTitle,
          task: () => _model.uploadBackup(),
        );
      },
    );
  }

  void _onRestoreBackupClicked() {
    _model.fetchBackupFileList();
    showDialog(
      context: context,
      builder: (context) => ChangeNotifierProvider.value(
        value: _model,
        child: FilePickerDialog(
          onFileItemSelected: _onBackupFileSelected,
        ),
      ),
    );
  }

  void _onBackupFileSelected(FileItem fileItem) async {
    final shouldRestore = await showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDialog(
        title: LocalizationUtil.localize(context)
            .restoreConfirmDialogTitle(fileItem.name),
      ),
    );

    if (shouldRestore != true) {
      return;
    }

    if (!mounted) {
      return;
    }

    showDialog(
      context: context,
      barrierColor: Colors.black87,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LoadingDialog(
          inProgressTitle: LocalizationUtil.localize(context)
              .restoreFromGoogleDriveInProgressTitle,
          completeTitle: LocalizationUtil.localize(context)
              .restoreFromGoogleDriveCompleteTitle,
          task: () => _model.restoreBackup(fileItem),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _model),
      ],
      child: _view(),
    );
  }

  Widget _view() {
    return Consumer<BackupSettingViewModel>(
      builder: (context, viewModel, child) {
        final backupSettingUiState = viewModel.backupSettingUiState;

        return backupSettingUiState.run(
          onLoading: () => const SizedBox(),
          onSuccess: (success) {
            return SettingGroup(
              title: LocalizationUtil.localize(context).settingBackupTitle,
              settingList: [
                SettingListTitle(
                  title: LocalizationUtil.localize(context)
                      .settingGoogleDriveBackupTitle,
                  onTap: _onUploadBackupClicked,
                ),
                SettingListTitle(
                  title: LocalizationUtil.localize(context)
                      .settingGoogleDriveRestoreTitle,
                  onTap: _onRestoreBackupClicked,
                ),
              ],
            );
          },
          onError: () => const SizedBox(),
        );
      },
    );
  }
}
