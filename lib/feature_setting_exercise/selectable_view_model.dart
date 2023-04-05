import '../core_view/ui_state/selectable.dart';
import '../core_view/view_model.dart';

mixin SelectableViewModel<T extends Selectable> on ViewModel {
  final selectedItems = <T>{};
  int get selectedItemCount => selectedItems.length;

  void select(T selectable) {
    final isSelected = selectable.isSelected;
    if (isSelected) {
      selectedItems.remove(selectable);
    } else {
      selectedItems.add(selectable);
    }
    selectable.isSelected = !isSelected;
    stateChange();
  }

  void unselectAll() {
    for (final selectable in selectedItems) {
      selectable.isSelected = false;
    }
    selectedItems.clear();
    stateChange();
  }
}