import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:workout_app/database/dao/composed_workout_dao.dart';
import 'package:workout_app/database/dao/exercise_dao.dart';
import 'package:workout_app/database/dao/exercise_set_dao.dart';
import 'package:workout_app/database/dao/workout_dao.dart';
import 'package:workout_app/database/dao/workout_detail_dao.dart';
import 'package:workout_app/database/model/embedded_object/exercise_with_sets_entity.dart';
import 'package:workout_app/database/model/embedded_object/workout_with_exercises_and_sets_entity.dart';
import 'package:workout_app/database/model/exercise_entity.dart';
import 'package:workout_app/database/model/exercise_set_entity.dart';
import 'package:workout_app/database/model/workout_detail_entity.dart';
import 'package:workout_app/database/model/workout_entity.dart';

import 'dao_test_util.dart';

void main() {
  late Future<Database> database;
  late ExerciseDao exerciseDao;
  late WorkoutDao workoutDao;
  late WorkoutDetailDao workoutDetailDao;
  late ExerciseSetDao exerciseSetDao;
  late ComposedWorkoutDao composedWorkoutDao;

  setUpAll(() async {
    database = setUpDatabase();

    exerciseDao = ExerciseDao();
    await exerciseDao.init(database);
    workoutDao = WorkoutDao();
    await workoutDao.init(database);
    workoutDetailDao = WorkoutDetailDao();
    await workoutDetailDao.init(database);
    exerciseSetDao = ExerciseSetDao();
    await exerciseSetDao.init(database);
    composedWorkoutDao = ComposedWorkoutDao();
    await composedWorkoutDao.init(database);
  });

  setUp(() async {
    // GIVEN
    await exerciseDao.add(ExerciseEntity.create(
      name: "Squat",
    ));
    await exerciseDao.add(
      ExerciseEntity.create(name: "Bench press"),
    );
    await exerciseDao.add(
      ExerciseEntity.create(name: "Deadlift"),
    );
    await workoutDao.add(
      WorkoutEntity.create(
        createDateTime: 1,
        startDateTime: 2,
        endDateTime: 7,
      ),
    );
    await workoutDao.add(
      WorkoutEntity.create(
        createDateTime: 101,
        startDateTime: 102,
        endDateTime: 106,
      ),
    );
    await workoutDetailDao.add(
      WorkoutDetailEntity(
        workoutId: 1,
        exerciseId: 1,
        createDateTime: 3,
      ),
    );
    await workoutDetailDao.add(
      WorkoutDetailEntity(
        workoutId: 1,
        exerciseId: 2,
        createDateTime: 6,
      ),
    );
    await workoutDetailDao.add(
      WorkoutDetailEntity(
        workoutId: 2,
        exerciseId: 3,
        createDateTime: 103,
      ),
    );

    // WHEN
    await exerciseSetDao.add(ExerciseSetEntity.create(
      workoutId: 1,
      exerciseId: 1,
      baseWeight: 20,
      sideWeight: 0,
      repetition: 5,
      endDateTime: 4,
    ));
    await exerciseSetDao.add(ExerciseSetEntity.create(
      workoutId: 1,
      exerciseId: 1,
      baseWeight: 20,
      sideWeight: 10,
      repetition: 5,
      endDateTime: 5,
    ));
    await exerciseSetDao.add(ExerciseSetEntity.create(
      workoutId: 1,
      exerciseId: 2,
      baseWeight: 0,
      sideWeight: 10,
      repetition: 5,
      endDateTime: 7,
    ));
    await exerciseSetDao.add(ExerciseSetEntity.create(
      workoutId: 1,
      exerciseId: 2,
      baseWeight: 0,
      sideWeight: 12.5,
      repetition: 5,
      endDateTime: 8,
    ));
    await exerciseSetDao.add(ExerciseSetEntity.create(
      workoutId: 2,
      exerciseId: 3,
      baseWeight: 20,
      sideWeight: 25,
      repetition: 5,
      endDateTime: 104,
    ));
    await exerciseSetDao.add(ExerciseSetEntity.create(
      workoutId: 2,
      exerciseId: 3,
      baseWeight: 20,
      sideWeight: 35,
      repetition: 5,
      endDateTime: 105,
    ));
  });

  tearDown(() async {
    final result1 = await exerciseSetDao.delete(
      ExerciseSetEntityFilter(workoutIds: [1, 2]),
    );
    final result2 = await workoutDetailDao.delete(
      WorkoutDetailEntityFilter(workoutIds: [1, 2]),
    );
    final result3 = await exerciseDao.delete(
      ExerciseEntityFilter(ids: [1, 2, 3]),
    );
    final result4 = await workoutDao.delete(
      WorkoutEntityFilter(ids: [1, 2]),
    );

    // THEN
    expect(successData(result1), true);
    expect(successData(result2), true);
    expect(successData(result3), true);
    expect(successData(result4), true);
  });

  test('Find all', () async {
    // WHEN
    final result = await composedWorkoutDao.findAll();

    // THEN
    final data = successData(result);
    expect(data.length, 2);

    final deadlift = ExerciseEntity(
      exerciseId: 3,
      name: "Deadlift",
    );

    verifyWorkoutWithExercisesAndSetsEntity(
      data[0],
      expectedEntity: WorkoutWithExercisesAndSetsEntity(
        workoutEntity: WorkoutEntity(
          workoutId: 2,
          createDateTime: 101,
          startDateTime: 102,
          endDateTime: 106,
        ),
        exerciseWithSetsEntityMap: {
          deadlift: ExerciseWithSetsEntity(
            exerciseEntity: deadlift,
            exerciseSetEntities: [
              ExerciseSetEntity(
                workoutId: 2,
                exerciseId: 3,
                setNum: 1,
                baseWeight: 20,
                sideWeight: 25,
                repetition: 5,
                endDateTime: 104,
              ),
              ExerciseSetEntity(
                workoutId: 2,
                exerciseId: 3,
                setNum: 2,
                baseWeight: 20,
                sideWeight: 35,
                repetition: 5,
                endDateTime: 105,
              ),
            ],
          ),
        },
      ),
    );

    final squat = ExerciseEntity(
      exerciseId: 1,
      name: "Squat",
    );
    final benchPress = ExerciseEntity(
      exerciseId: 2,
      name: "Bench press",
    );

    verifyWorkoutWithExercisesAndSetsEntity(
      data[1],
      expectedEntity: WorkoutWithExercisesAndSetsEntity(
        workoutEntity: WorkoutEntity(
          workoutId: 1,
          createDateTime: 1,
          startDateTime: 2,
          endDateTime: 7,
        ),
        exerciseWithSetsEntityMap: {
          squat: ExerciseWithSetsEntity(
            exerciseEntity: squat,
            exerciseSetEntities: [
              ExerciseSetEntity(
                workoutId: 1,
                exerciseId: 1,
                setNum: 1,
                baseWeight: 20,
                sideWeight: 0,
                repetition: 5,
                endDateTime: 4,
              ),
              ExerciseSetEntity(
                workoutId: 1,
                exerciseId: 1,
                setNum: 2,
                baseWeight: 20,
                sideWeight: 10,
                repetition: 5,
                endDateTime: 5,
              ),
            ],
          ),
          benchPress: ExerciseWithSetsEntity(
            exerciseEntity: benchPress,
            exerciseSetEntities: [
              ExerciseSetEntity(
                workoutId: 1,
                exerciseId: 2,
                setNum: 1,
                baseWeight: 0,
                sideWeight: 10,
                repetition: 5,
                endDateTime: 7,
              ),
              ExerciseSetEntity(
                workoutId: 1,
                exerciseId: 2,
                setNum: 2,
                baseWeight: 0,
                sideWeight: 12.5,
                repetition: 5,
                endDateTime: 8,
              ),
            ],
          ),
        },
      ),
    );
  });

  test('Find by filter', () async {
    // GIVEN
    final filter = ComposedWorkoutFilter(workoutIds: [1]);

    // WHEN
    final result = await composedWorkoutDao.findByFilter(filter);

    // THEN
    final data = successData(result);
    expect(data.length, 1);

    final squat = ExerciseEntity(
      exerciseId: 1,
      name: "Squat",
    );
    final benchPress = ExerciseEntity(
      exerciseId: 2,
      name: "Bench press",
    );

    verifyWorkoutWithExercisesAndSetsEntity(
      data[0],
      expectedEntity: WorkoutWithExercisesAndSetsEntity(
        workoutEntity: WorkoutEntity(
          workoutId: 1,
          createDateTime: 1,
          startDateTime: 2,
          endDateTime: 7,
        ),
        exerciseWithSetsEntityMap: {
          squat: ExerciseWithSetsEntity(
            exerciseEntity: squat,
            exerciseSetEntities: [
              ExerciseSetEntity(
                workoutId: 1,
                exerciseId: 1,
                setNum: 1,
                baseWeight: 20,
                sideWeight: 0,
                repetition: 5,
                endDateTime: 4,
              ),
              ExerciseSetEntity(
                workoutId: 1,
                exerciseId: 1,
                setNum: 2,
                baseWeight: 20,
                sideWeight: 10,
                repetition: 5,
                endDateTime: 5,
              ),
            ],
          ),
          benchPress: ExerciseWithSetsEntity(
            exerciseEntity: benchPress,
            exerciseSetEntities: [
              ExerciseSetEntity(
                workoutId: 1,
                exerciseId: 2,
                setNum: 1,
                baseWeight: 0,
                sideWeight: 10,
                repetition: 5,
                endDateTime: 7,
              ),
              ExerciseSetEntity(
                workoutId: 1,
                exerciseId: 2,
                setNum: 2,
                baseWeight: 0,
                sideWeight: 12.5,
                repetition: 5,
                endDateTime: 8,
              ),
            ],
          ),
        },
      ),
    );
  });

  test('Add (not supported)', () async {
    await expectLater(
      () => composedWorkoutDao.add(
        WorkoutWithExercisesAndSetsEntity(
          workoutEntity: WorkoutEntity(
            workoutId: 0,
            createDateTime: 0,
            startDateTime: 0,
            endDateTime: 0,
          ),
          exerciseWithSetsEntityMap: const {},
        ),
      ),
      throwsA(isA<UnimplementedError>()),
    );
  });

  test('Update (not supported)', () async {
    await expectLater(
      () => composedWorkoutDao.update(
        WorkoutWithExercisesAndSetsEntity(
          workoutEntity: WorkoutEntity(
            workoutId: 0,
            createDateTime: 0,
            startDateTime: 0,
            endDateTime: 0,
          ),
          exerciseWithSetsEntityMap: const {},
        ),
      ),
      throwsA(isA<UnimplementedError>()),
    );
  });

  test('Delete (not supported)', () async {
    await expectLater(
      () => composedWorkoutDao.delete(ComposedWorkoutFilter(workoutIds: [])),
      throwsA(isA<UnimplementedError>()),
    );
  });
}
