import 'ui_mode.dart';
import 'view_model.dart';

class UiModeViewModel extends ViewModel {

  UiMode _uiMode = UiMode.normal;
  UiMode get uiMode => _uiMode;

  @override
  Future<void> init() async {
    // do nothing
  }

  void switchTo(UiMode mode) {
    _uiMode = mode;
    stateChange();
  }
}
