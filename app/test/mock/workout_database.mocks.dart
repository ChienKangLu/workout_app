// Mocks generated by Mockito 5.4.2 from annotations
// in workout_app/test/mock/workout_database.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i10;
import 'dart:io' as _i11;

import 'package:mockito/mockito.dart' as _i1;
import 'package:workout_app/database/dao/composed_workout_dao.dart' as _i6;
import 'package:workout_app/database/dao/exercise_dao.dart' as _i3;
import 'package:workout_app/database/dao/exercise_set_dao.dart' as _i5;
import 'package:workout_app/database/dao/water_goal_dao.dart' as _i7;
import 'package:workout_app/database/dao/water_log_dao.dart' as _i8;
import 'package:workout_app/database/dao/workout_dao.dart' as _i2;
import 'package:workout_app/database/dao/workout_detail_dao.dart' as _i4;
import 'package:workout_app/database/database_initializer.dart' as _i12;
import 'package:workout_app/database/workout_database.dart' as _i9;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeWorkoutDao_0 extends _i1.SmartFake implements _i2.WorkoutDao {
  _FakeWorkoutDao_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeExerciseDao_1 extends _i1.SmartFake implements _i3.ExerciseDao {
  _FakeExerciseDao_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWorkoutDetailDao_2 extends _i1.SmartFake
    implements _i4.WorkoutDetailDao {
  _FakeWorkoutDetailDao_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeExerciseSetDao_3 extends _i1.SmartFake
    implements _i5.ExerciseSetDao {
  _FakeExerciseSetDao_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeComposedWorkoutDao_4 extends _i1.SmartFake
    implements _i6.ComposedWorkoutDao {
  _FakeComposedWorkoutDao_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWaterGoalDao_5 extends _i1.SmartFake implements _i7.WaterGoalDao {
  _FakeWaterGoalDao_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWaterLogDao_6 extends _i1.SmartFake implements _i8.WaterLogDao {
  _FakeWaterLogDao_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [WorkoutDatabase].
///
/// See the documentation for Mockito's code generation for more information.
class MockWorkoutDatabase extends _i1.Mock implements _i9.WorkoutDatabase {
  MockWorkoutDatabase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.WorkoutDao get workoutDao => (super.noSuchMethod(
        Invocation.getter(#workoutDao),
        returnValue: _FakeWorkoutDao_0(
          this,
          Invocation.getter(#workoutDao),
        ),
      ) as _i2.WorkoutDao);

  @override
  _i3.ExerciseDao get exerciseDao => (super.noSuchMethod(
        Invocation.getter(#exerciseDao),
        returnValue: _FakeExerciseDao_1(
          this,
          Invocation.getter(#exerciseDao),
        ),
      ) as _i3.ExerciseDao);

  @override
  _i4.WorkoutDetailDao get workoutDetailDao => (super.noSuchMethod(
        Invocation.getter(#workoutDetailDao),
        returnValue: _FakeWorkoutDetailDao_2(
          this,
          Invocation.getter(#workoutDetailDao),
        ),
      ) as _i4.WorkoutDetailDao);

  @override
  _i5.ExerciseSetDao get exerciseSetDao => (super.noSuchMethod(
        Invocation.getter(#exerciseSetDao),
        returnValue: _FakeExerciseSetDao_3(
          this,
          Invocation.getter(#exerciseSetDao),
        ),
      ) as _i5.ExerciseSetDao);

  @override
  _i6.ComposedWorkoutDao get composedWorkoutDao => (super.noSuchMethod(
        Invocation.getter(#composedWorkoutDao),
        returnValue: _FakeComposedWorkoutDao_4(
          this,
          Invocation.getter(#composedWorkoutDao),
        ),
      ) as _i6.ComposedWorkoutDao);

  @override
  _i7.WaterGoalDao get waterGoalDao => (super.noSuchMethod(
        Invocation.getter(#waterGoalDao),
        returnValue: _FakeWaterGoalDao_5(
          this,
          Invocation.getter(#waterGoalDao),
        ),
      ) as _i7.WaterGoalDao);

  @override
  _i8.WaterLogDao get waterLogDao => (super.noSuchMethod(
        Invocation.getter(#waterLogDao),
        returnValue: _FakeWaterLogDao_6(
          this,
          Invocation.getter(#waterLogDao),
        ),
      ) as _i8.WaterLogDao);

  @override
  String get dbPath => (super.noSuchMethod(
        Invocation.getter(#dbPath),
        returnValue: '',
      ) as String);

  @override
  _i10.Future<void> init() => (super.noSuchMethod(
        Invocation.method(
          #init,
          [],
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);

  @override
  _i10.Future<void> restoreBackup(_i11.File? backup) => (super.noSuchMethod(
        Invocation.method(
          #restoreBackup,
          [backup],
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);

  @override
  _i10.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);

  @override
  void setUpDatabaseInitializer(
          _i12.DatabaseInitializer? databaseInitializer) =>
      super.noSuchMethod(
        Invocation.method(
          #setUpDatabaseInitializer,
          [databaseInitializer],
        ),
        returnValueForMissingStub: null,
      );
}
