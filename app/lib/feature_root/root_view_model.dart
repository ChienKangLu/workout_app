import '../core_view/view_model.dart';

class RootViewModel extends ViewModel {
  bool _isNavigationVisible = true;
  bool get isNavigationVisible => _isNavigationVisible;
  set isNavigationVisible(bool value) {
    _isNavigationVisible = value;
    stateChange();
  }

  @override
  Future<void> reload() async {
    // do nothing
  }
}
