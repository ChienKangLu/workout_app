import '../core_view/view_model.dart';
import '../use_case/exercise_use_case.dart';
import 'selectable_view_model.dart';
import 'ui_state/exercise_option_list_ui_state.dart';

class SettingExerciseViewModel extends ViewModel
    with SelectableViewModel<ExerciseOption> {
  final ExerciseUseCase _exerciseUseCase = ExerciseUseCase();

  ExerciseOptionListUiState _exerciseOptionListUiState =
      ExerciseOptionListUiState.loading();
  ExerciseOptionListUiState get exerciseOptionListUiState =>
      _exerciseOptionListUiState;

  @override
  Future<void> init() async {
    await _updateExerciseOptionListUiState();
    stateChange();
  }

  @override
  Future<void> reload() async {
    if (_exerciseOptionListUiState is! ExerciseOptionListLoadingUiState) {
      _exerciseOptionListUiState = ExerciseOptionListUiState.loading();
      stateChange();
    }

    await _updateExerciseOptionListUiState();
    stateChange();
  }

  Future<void> _updateExerciseOptionListUiState() async {
    final exercises = await _exerciseUseCase.getExercises();
    if (exercises == null) {
      _exerciseOptionListUiState = ExerciseOptionListUiState.error();
      return;
    }

    _exerciseOptionListUiState = ExerciseOptionListUiState.success(
      exercises
          .map(
            (exercise) => ExerciseOption(
              exerciseId: exercise.exerciseId,
              name: exercise.name,
            ),
          )
          .toList(),
    );
  }

  Future<void> createExercise(String name) async {
    final result = await _exerciseUseCase.createExercise(name);
    if (result == null) {
      return;
    }

    reload();
  }

  Future<void> updateExercise({
    required int exerciseId,
    required String name,
  }) async {
    final result = await _exerciseUseCase.updateExercise(
      exerciseId: exerciseId,
      name: name,
    );
    if (result == false) {
      return;
    }

    reload();
  }

  Future<void> deleteSelectedExerciseOptions() async {
    final ids = selectedItems
        .map((exercise) => exercise.exerciseId)
        .toList(growable: false);

    selectedItems.clear();

    await deleteExerciseOption(ids);
  }

  Future<void> deleteExerciseOption(List<int> exerciseIds) async {
    await _exerciseUseCase.removeExercises(exerciseIds);

    reload();
  }
}
