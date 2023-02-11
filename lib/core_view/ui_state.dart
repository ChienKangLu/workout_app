enum UiStatus {
  loading,
  success,
  error,
}

abstract class UiState {
  UiState({
    required this.status,
  });

  final UiStatus status;

  T run<T>({
    required T Function() onLoading,
    required T Function() onSuccess,
    required T Function() onError,
  }) {
    switch (status) {
      case UiStatus.loading:
        return onLoading();
      case UiStatus.success:
        return onSuccess();
      case UiStatus.error:
        return onError.call();
    }
  }

  bool get isLoading => status == UiStatus.loading;
  bool get isSuccess => status == UiStatus.success;
  bool get isError => status == UiStatus.error;
}
