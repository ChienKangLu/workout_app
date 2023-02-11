import 'package:flutter/foundation.dart';

abstract class ViewModel extends ChangeNotifier {

  /// Lifecycle method to init [ViewMode].
  Future<void> init();

  /// Lifecycle method to update [ViewMode] after [init] is called.
  Future<void> update();

  /// Lifecycle method to release resources.
  void release() {
    dispose();
  }

  /// Must called when any state in [ViewModel] is changed.
  @protected
  void stateChange() {
    notifyListeners();
  }
}