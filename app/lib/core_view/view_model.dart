import 'package:flutter/foundation.dart';

import '../repository/database_repository.dart';
import '../repository/repository_manager.dart';

abstract class ViewModel extends ChangeNotifier implements DatabaseObserver {

  /// Lifecycle method to init [ViewMode].
  @mustCallSuper
  Future<void> init() async {
    RepositoryManager.instance.databaseRepository.addObserver(this);
  }

  /// Lifecycle method to reload [ViewMode].
  Future<void> reload();

  /// Lifecycle method to release resources.
  @mustCallSuper
  void release() {
    RepositoryManager.instance.databaseRepository.removeObserver(this);
    dispose();
  }

  /// Must called when any state in [ViewModel] is changed.
  @protected
  @mustCallSuper
  void stateChange() {
    notifyListeners();
  }

  @override
  @mustCallSuper
  Future<void> didDatabaseBackupRestored() async {
    await reload();
  }
}