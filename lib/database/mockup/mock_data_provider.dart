import '../model/exercise_entity.dart';
import '../model/running_set_entity.dart';
import '../model/weight_training_set_entity.dart';
import '../model/workout_detail_entity.dart';
import '../model/workout_entity.dart';
import '../model/workout_type_entity.dart';

class MockDataProvider {
  MockDataProvider._();
  static final MockDataProvider instance = MockDataProvider._();

  static final _firstDay = DateTime.now().subtractDays(3);
  static final _secondDay = _firstDay.addDays(1);
  static final _thirdDay = _firstDay.addDays(2);

  static List<WorkoutEntity>? _workoutEntities;
  List<WorkoutEntity> get workoutEntities {
    _workoutEntities ??= [
      WorkoutEntity.create(
        workoutTypeEntity: WorkoutTypeEntity.weightTraining,
        createDateTime: _firstDay.millisecondsSinceEpoch,
        startDateTime: _firstDay.millisecondsSinceEpoch,
        endDateTime: _firstDay.addHours(1).millisecondsSinceEpoch,
      ),
      WorkoutEntity.create(
        workoutTypeEntity: WorkoutTypeEntity.running,
        createDateTime: _secondDay.millisecondsSinceEpoch,
        startDateTime: _secondDay.millisecondsSinceEpoch,
        endDateTime: _secondDay.addMinutes(15).millisecondsSinceEpoch,
      ),
      WorkoutEntity.create(
        workoutTypeEntity: WorkoutTypeEntity.weightTraining,
        createDateTime: _thirdDay.millisecondsSinceEpoch,
        startDateTime: _thirdDay.millisecondsSinceEpoch,
        endDateTime: _thirdDay.addHours(1).millisecondsSinceEpoch,
      ),
    ];
    return _workoutEntities!;
  }

  static List<ExerciseEntity>? _exerciseEntities;
  List<ExerciseEntity> get exerciseEntities {
    _exerciseEntities ??= [
      ExerciseEntity.create(
        name: "Squat",
        workoutType: WorkoutTypeEntity.weightTraining,
      ),
      ExerciseEntity.create(
        name: "Bench Press",
        workoutType: WorkoutTypeEntity.weightTraining,
      ),
      ExerciseEntity.create(
        name: "Deadlift",
        workoutType: WorkoutTypeEntity.weightTraining,
      ),
      ExerciseEntity.create(
        name: "Jogging",
        workoutType: WorkoutTypeEntity.running,
      ),
    ];
    return _exerciseEntities!;
  }

  static List<WorkoutDetailEntity>? _workoutDetailEntities;
  List<WorkoutDetailEntity> get workoutDetailEntities {
    const firstWorkoutId = 1;
    const squatId = 1;
    const benchPressId = 2;

    const secondWorkoutId = 2;
    const joggingId = 4;

    const thirdWorkoutId = 3;
    const deadliftId = 3;

    _workoutDetailEntities ??= [
      WorkoutDetailEntity(
        workoutId: firstWorkoutId,
        exerciseId: squatId,
        createDateTime: _firstDay.addMinutes(1).millisecondsSinceEpoch,
      ),
      WorkoutDetailEntity(
        workoutId: firstWorkoutId,
        exerciseId: benchPressId,
        createDateTime: _firstDay.addMinutes(5).millisecondsSinceEpoch,
      ),
      WorkoutDetailEntity(
        workoutId: secondWorkoutId,
        exerciseId: joggingId,
        createDateTime: _secondDay.addMinutes(1).millisecondsSinceEpoch,
      ),
      WorkoutDetailEntity(
        workoutId: thirdWorkoutId,
        exerciseId: deadliftId,
        createDateTime: _thirdDay.addMinutes(1).millisecondsSinceEpoch,
      ),
    ];
    return _workoutDetailEntities!;
  }

  static List<WeightTrainingSetEntity>? _weightTrainingSetEntities;
  List<WeightTrainingSetEntity> get weightTrainingSetEntities {
    const firstWorkoutId = 1;
    const squatId = 1;
    const benchPressId = 2;

    const thirdWorkoutId = 3;
    const deadliftId = 3;

    _weightTrainingSetEntities ??= [
      WeightTrainingSetEntity(
        workoutId: firstWorkoutId,
        exerciseId: squatId,
        setNum: 1,
        baseWeight: 20,
        sideWeight: 15,
        repetition: 5,
        endDateTime: _firstDay.addMinutes(2).millisecondsSinceEpoch,
      ),
      WeightTrainingSetEntity(
          workoutId: firstWorkoutId,
          exerciseId: squatId,
          setNum: 2,
          baseWeight: 20,
          sideWeight: 17.5,
          repetition: 5,
          endDateTime: _firstDay.addMinutes(4).millisecondsSinceEpoch),
      WeightTrainingSetEntity(
          workoutId: firstWorkoutId,
          exerciseId: benchPressId,
          setNum: 1,
          baseWeight: 20,
          sideWeight: 20,
          repetition: 5,
          endDateTime: _firstDay.addMinutes(6).millisecondsSinceEpoch),
      WeightTrainingSetEntity(
          workoutId: thirdWorkoutId,
          exerciseId: deadliftId,
          setNum: 1,
          baseWeight: 20,
          sideWeight: 10,
          repetition: 5,
          endDateTime: _thirdDay.addMinutes(2).millisecondsSinceEpoch),
      WeightTrainingSetEntity(
          workoutId: thirdWorkoutId,
          exerciseId: deadliftId,
          setNum: 2,
          baseWeight: 20,
          sideWeight: 15,
          repetition: 5,
          endDateTime: _thirdDay.addMinutes(4).millisecondsSinceEpoch),
      WeightTrainingSetEntity(
          workoutId: thirdWorkoutId,
          exerciseId: deadliftId,
          setNum: 3,
          baseWeight: 20,
          sideWeight: 20,
          repetition: 5,
          endDateTime: _thirdDay.addMinutes(6).millisecondsSinceEpoch),
      WeightTrainingSetEntity(
          workoutId: thirdWorkoutId,
          exerciseId: deadliftId,
          setNum: 4,
          baseWeight: 20,
          sideWeight: 25,
          repetition: 5,
          endDateTime: _thirdDay.addMinutes(10).millisecondsSinceEpoch),
      WeightTrainingSetEntity(
          workoutId: thirdWorkoutId,
          exerciseId: deadliftId,
          setNum: 5,
          baseWeight: 20,
          sideWeight: 30,
          repetition: 5,
          endDateTime: _thirdDay.addMinutes(12).millisecondsSinceEpoch),
    ];
    return _weightTrainingSetEntities!;
  }

  static List<RunningSetEntity>? _runningSetEntities;
  List<RunningSetEntity> get runningSetEntities {
    const secondWorkoutId = 2;
    const joggingId = 4;

    _runningSetEntities ??= [
      RunningSetEntity(
        workoutId: secondWorkoutId,
        exerciseId: joggingId,
        setNum: 1,
        duration: const Duration(minutes: 2).inMilliseconds.toDouble(),
        distance: 400,
        endDateTime: _secondDay.addMinutes(2).millisecondsSinceEpoch,
      ),
      RunningSetEntity(
          workoutId: secondWorkoutId,
          exerciseId: joggingId,
          setNum: 2,
          duration: const Duration(minutes: 3).inMilliseconds.toDouble(),
          distance: 400,
          endDateTime: _secondDay.addMinutes(5).millisecondsSinceEpoch),
      RunningSetEntity(
          workoutId: secondWorkoutId,
          exerciseId: joggingId,
          setNum: 3,
          duration: const Duration(minutes: 4).inMilliseconds.toDouble(),
          distance: 400,
          endDateTime: _secondDay.addMinutes(9).millisecondsSinceEpoch),
    ];
    return _runningSetEntities!;
  }
}

extension _DateTimeExtension on DateTime {
  DateTime addDays(int days) => add(Duration(days: days));
  DateTime addHours(int hours) => add(Duration(hours: hours));
  DateTime addMinutes(int minutes) => add(Duration(minutes: minutes));

  DateTime subtractDays(int days) => subtract(Duration(days: days));
}
