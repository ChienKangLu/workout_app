abstract class FilePickerUiState {
  FilePickerUiState();

  factory FilePickerUiState.loading() => FilePickerLoadingUiState();

  factory FilePickerUiState.success(
    List<FileItem> fileItems,
  ) =>
      FilePickerSuccessUiState(fileItems);

  factory FilePickerUiState.error() => FilePickerErrorUiState();

  T run<T>({
    required T Function() onLoading,
    required T Function(FilePickerSuccessUiState) onSuccess,
    required T Function() onError,
  }) {
    if (this is FilePickerLoadingUiState) {
      return onLoading();
    } else if (this is FilePickerSuccessUiState) {
      return onSuccess(this as FilePickerSuccessUiState);
    } else {
      return onError();
    }
  }
}

class FilePickerLoadingUiState extends FilePickerUiState {
  static final FilePickerLoadingUiState _instance =
      FilePickerLoadingUiState._internal();

  factory FilePickerLoadingUiState() {
    return _instance;
  }

  FilePickerLoadingUiState._internal();
}

class FilePickerSuccessUiState extends FilePickerUiState {
  FilePickerSuccessUiState(this.fileItems);

  final List<FileItem> fileItems;
}

class FilePickerErrorUiState extends FilePickerUiState {
  static final FilePickerErrorUiState _instance =
      FilePickerErrorUiState._internal();

  factory FilePickerErrorUiState() {
    return _instance;
  }

  FilePickerErrorUiState._internal();
}

class FileItem {
  FileItem({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;
}
