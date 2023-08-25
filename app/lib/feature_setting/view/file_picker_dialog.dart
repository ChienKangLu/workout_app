import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core_view/custom_dialog.dart';
import '../../core_view/list_item.dart';
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
              ? Column(
                  children: [
                    const Spacer(flex: 1),
                    const Icon(
                      Icons.file_copy,
                      size: 100,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      LocalizationUtil.localize(context)
                          .settingEmptyBackupFileTitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const Spacer(flex: 3),
                  ],
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
