import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core_view/custom_dialog.dart';
import '../../core_view/empty_view.dart';
import '../../core_view/list_item.dart';
import '../../util/assets.dart';
import '../../util/localization_util.dart';
import '../backup_setting_view_model.dart';
import '../ui_state/file_picker_ui_state.dart';

class FilePickerDialog extends StatefulWidget {
  const FilePickerDialog({
    Key? key,
    required this.onFileItemSelected,
  }) : super(key: key);

  final void Function(FileItem) onFileItemSelected;

  @override
  State<FilePickerDialog> createState() => _FilePickerDialogState();
}

class _FilePickerDialogState extends State<FilePickerDialog> {
  @override
  Widget build(BuildContext context) {
    final filePickerUiState =
        context.watch<BackupSettingViewModel>().filePickerUiState;

    return filePickerUiState.run(
      onLoading: () => CustomDialog(
        title: LocalizationUtil.localize(context).settingBackupFilePickerTitle,
        child: const Column(
          children: [CircularProgressIndicator()],
        ),
      ),
      onSuccess: (success) {
        final fileItems = success.fileItems;

        return CustomDialog(
          title:
              LocalizationUtil.localize(context).settingBackupFilePickerTitle,
          child: fileItems.isEmpty
              ? EmptyView(
                  assetName: Assets.backupEmpty,
                  header: LocalizationUtil.localize(context).backupEmptyHeader,
                  body: LocalizationUtil.localize(context).backupEmptyBody,
                )
              : ListView.builder(
                  itemCount: fileItems.length,
                  itemBuilder: (context, index) {
                    final fileItem = fileItems[index];
                    return ListItem(
                        text: fileItem.name,
                        onTap: () {
                          Navigator.pop(context);
                          widget.onFileItemSelected(fileItem);
                        });
                  },
                ),
        );
      },
      onError: () => const SizedBox(),
    );
  }
}
