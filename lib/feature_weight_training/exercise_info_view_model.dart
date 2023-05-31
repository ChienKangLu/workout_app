import '../core_view/view_model.dart';
import '../use_case/exercise_use_case.dart';
import 'ui_state/exercise_info_ui_state.dart';

class ExerciseInfoViewModel extends ViewModel {
  static const _tag = "ExerciseInfoViewModel";

  ExerciseInfoViewModel({
    required this.exerciseId,
  });

  final int exerciseId;
  final ExerciseUseCase _exerciseUseCase = ExerciseUseCase();

  ExerciseInfoUiState _exerciseInfoUiState = ExerciseInfoUiState.loading();
  ExerciseInfoUiState get exerciseInfoUiState => _exerciseInfoUiState;

  @override
  Future<void> init() async {
    await _updateExerciseInfoUiState();
    stateChange();
  }

  Future<void> _updateExerciseInfoUiState() async {
    final exerciseStatistic =
        await _exerciseUseCase.getExerciseStatistic(exerciseId);
    if (exerciseStatistic == null) {
      _exerciseInfoUiState = ExerciseInfoUiState.error();
      return;
    }

    _exerciseInfoUiState = ExerciseInfoUiState.success(
      ExerciseInfo(
        name: exerciseStatistic.name,
        exerciseId: exerciseStatistic.exerciseId,
        max: exerciseStatistic.max,
      ),
    );
  }
}
