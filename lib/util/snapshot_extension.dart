import 'package:flutter/material.dart';

extension FutureExtension<T> on AsyncSnapshot<T> {
  Widget handle({
    Widget Function()? onWaiting,
    Widget Function()? onError,
    Widget Function()? onEmptyData,
    required Widget Function(T data) onDone,
  }) {
    if (connectionState == ConnectionState.waiting) {
      return onWaiting != null ? onWaiting() : const SizedBox();
    }

    if (hasError) {
      return onError != null ? onError() : const SizedBox();
    }

    if (data == null) {
      return onEmptyData != null ? onEmptyData() : const SizedBox();
    }

    return onDone(data as T);
  }
}
