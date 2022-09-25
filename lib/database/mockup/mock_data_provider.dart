import '../model/exercise_entity.dart';
import '../model/running_entity.dart';
import '../model/weight_training_entity.dart';
import '../model/workout_record_entity.dart';
import '../model/workout_type_entity.dart';

class MockDataProvider {
  MockDataProvider._();
  static final MockDataProvider instance = MockDataProvider._();

  static final _firstDay = DateTime.now();
  static final _secondDay = _firstDay.addDays(1);
  static final _thirdDay = _firstDay.addDays(2);

  static List<WorkoutRecordEntity>? _workoutRecordEntities;
  List<WorkoutRecordEntity> get workoutRecordEntities {
    _workoutRecordEntities ??= [
      WorkoutRecordEntity.create(
        workoutTypeId: WorkoutTypeEntity.weightTraining.id,
        startDateTime: _firstDay.microsecondsSinceEpoch,
        endDateTime: _firstDay.addHours(1).microsecondsSinceEpoch,
      ),
      WorkoutRecordEntity.create(
        workoutTypeId: WorkoutTypeEntity.running.id,
        startDateTime: _secondDay.microsecondsSinceEpoch,
        endDateTime: _secondDay.addMinutes(15).microsecondsSinceEpoch,
      ),
      WorkoutRecordEntity.create(
        workoutTypeId: WorkoutTypeEntity.weightTraining.id,
        startDateTime: _thirdDay.microsecondsSinceEpoch,
        endDateTime: _thirdDay.addHours(1).microsecondsSinceEpoch,
      ),
    ];
    return _workoutRecordEntities!;
  }

  static List<ExerciseEntity>? _exerciseEntities;
  List<ExerciseEntity> get exerciseEntities {
    _exerciseEntities ??= [
      ExerciseEntity.create(
        name: "Squat",
        workoutTypeId: WorkoutTypeEntity.weightTraining.id,
      ),
      ExerciseEntity.create(
        name: "Bench Press",
        workoutTypeId: WorkoutTypeEntity.weightTraining.id,
      ),
      ExerciseEntity.create(
        name: "Deadlift",
        workoutTypeId: WorkoutTypeEntity.weightTraining.id,
      ),
      ExerciseEntity.create(
        name: "Jogging",
        workoutTypeId: WorkoutTypeEntity.running.id,
      ),
    ];
    return _exerciseEntities!;
  }

  static List<WeightTrainingEntity>? _weightTrainingEntities;
  List<WeightTrainingEntity> get weightTrainingEntities {
    const firstWorkoutRecordId = 1;
    const squatTypeId = 1;
    const benchPressTypeId = 2;

    const thirdWorkoutRecordId = 3;
    const deadliftTypeId = 3;

    _weightTrainingEntities ??= [
      WeightTrainingEntity(
        workoutRecordId: firstWorkoutRecordId,
        exerciseTypeId: squatTypeId,
        setNum: 1,
        baseWeight: 20,
        sideWeight: 15,
        repetition: 5,
        endDateTime: _firstDay.addMinutes(2).microsecondsSinceEpoch,
      ),
      WeightTrainingEntity(
          workoutRecordId: firstWorkoutRecordId,
          exerciseTypeId: squatTypeId,
          setNum: 2,
          baseWeight: 20,
          sideWeight: 17.5,
          repetition: 5,
          endDateTime: _firstDay.addMinutes(4).microsecondsSinceEpoch),
      WeightTrainingEntity(
          workoutRecordId: firstWorkoutRecordId,
          exerciseTypeId: benchPressTypeId,
          setNum: 1,
          baseWeight: 20,
          sideWeight: 20,
          repetition: 5,
          endDateTime: _firstDay.addMinutes(6).microsecondsSinceEpoch),
      WeightTrainingEntity(
          workoutRecordId: thirdWorkoutRecordId,
          exerciseTypeId: deadliftTypeId,
          setNum: 1,
          baseWeight: 20,
          sideWeight: 20,
          repetition: 5,
          endDateTime: _thirdDay.addMinutes(2).microsecondsSinceEpoch),
      WeightTrainingEntity(
          workoutRecordId: thirdWorkoutRecordId,
          exerciseTypeId: deadliftTypeId,
          setNum: 2,
          baseWeight: 20,
          sideWeight: 20,
          repetition: 5,
          endDateTime: _thirdDay.addMinutes(4).microsecondsSinceEpoch),
      WeightTrainingEntity(
          workoutRecordId: thirdWorkoutRecordId,
          exerciseTypeId: deadliftTypeId,
          setNum: 3,
          baseWeight: 20,
          sideWeight: 20,
          repetition: 5,
          endDateTime: _thirdDay.addMinutes(6).microsecondsSinceEpoch),
      WeightTrainingEntity(
          workoutRecordId: thirdWorkoutRecordId,
          exerciseTypeId: deadliftTypeId,
          setNum: 4,
          baseWeight: 20,
          sideWeight: 20,
          repetition: 5,
          endDateTime: _thirdDay.addMinutes(10).microsecondsSinceEpoch),
      WeightTrainingEntity(
          workoutRecordId: thirdWorkoutRecordId,
          exerciseTypeId: deadliftTypeId,
          setNum: 5,
          baseWeight: 20,
          sideWeight: 20,
          repetition: 5,
          endDateTime: _thirdDay.addMinutes(12).microsecondsSinceEpoch),
    ];
    return _weightTrainingEntities!;
  }

  static List<RunningEntity>? _runningEntities;
  List<RunningEntity> get runningEntities {
    const secondWorkoutRecordId = 2;
    const joggingTypeId = 4;

    _runningEntities ??= [
      RunningEntity(
        workoutRecordId: secondWorkoutRecordId,
        exerciseTypeId: joggingTypeId,
        setNum: 1,
        duration: const Duration(minutes: 2).inMilliseconds.toDouble(),
        distance: 400,
        endDateTime: _secondDay.addMinutes(2).microsecondsSinceEpoch,
      ),
      RunningEntity(
          workoutRecordId: secondWorkoutRecordId,
          exerciseTypeId: joggingTypeId,
          setNum: 2,
          duration: const Duration(minutes: 3).inMilliseconds.toDouble(),
          distance: 400,
          endDateTime: _secondDay.addMinutes(5).microsecondsSinceEpoch),
      RunningEntity(
          workoutRecordId: secondWorkoutRecordId,
          exerciseTypeId: joggingTypeId,
          setNum: 3,
          duration: const Duration(minutes: 4).inMilliseconds.toDouble(),
          distance: 400,
          endDateTime: _secondDay.addMinutes(9).microsecondsSinceEpoch),
    ];
    return _runningEntities!;
  }
}

extension _DateTimeExtension on DateTime {
  DateTime addDays(int days) => add(Duration(days: days));
  DateTime addHours(int hours) => add(Duration(hours: hours));
  DateTime addMinutes(int minutes) => add(Duration(minutes: minutes));
}
