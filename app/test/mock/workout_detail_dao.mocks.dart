// Mocks generated by Mockito 5.4.2 from annotations
// in workout_app/test/mock/workout_detail_dao.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i2;
import 'package:workout_app/database/dao/dao_filter.dart' as _i7;
import 'package:workout_app/database/dao/dao_result.dart' as _i5;
import 'package:workout_app/database/dao/workout_detail_dao.dart' as _i4;
import 'package:workout_app/database/model/workout_detail_entity.dart' as _i3;

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

class _FakeDatabase_0 extends _i1.SmartFake implements _i2.Database {
  _FakeDatabase_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWorkoutDetailEntity_1 extends _i1.SmartFake
    implements _i3.WorkoutDetailEntity {
  _FakeWorkoutDetailEntity_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWorkoutDetailEntityFilter_2 extends _i1.SmartFake
    implements _i4.WorkoutDetailEntityFilter {
  _FakeWorkoutDetailEntityFilter_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDaoResult_3<T> extends _i1.SmartFake implements _i5.DaoResult<T> {
  _FakeDaoResult_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [WorkoutDetailDao].
///
/// See the documentation for Mockito's code generation for more information.
class MockWorkoutDetailDao extends _i1.Mock implements _i4.WorkoutDetailDao {
  MockWorkoutDetailDao() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get tag => (super.noSuchMethod(
        Invocation.getter(#tag),
        returnValue: '',
      ) as String);

  @override
  String get tableName => (super.noSuchMethod(
        Invocation.getter(#tableName),
        returnValue: '',
      ) as String);

  @override
  _i2.Database get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _FakeDatabase_0(
          this,
          Invocation.getter(#database),
        ),
      ) as _i2.Database);

  @override
  set database(_i2.Database? _database) => super.noSuchMethod(
        Invocation.setter(
          #database,
          _database,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.WorkoutDetailEntity createEntityFromMap(Map<String, dynamic>? map) =>
      (super.noSuchMethod(
        Invocation.method(
          #createEntityFromMap,
          [map],
        ),
        returnValue: _FakeWorkoutDetailEntity_1(
          this,
          Invocation.method(
            #createEntityFromMap,
            [map],
          ),
        ),
      ) as _i3.WorkoutDetailEntity);

  @override
  _i4.WorkoutDetailEntityFilter createUpdateFilter(
          _i3.WorkoutDetailEntity? entity) =>
      (super.noSuchMethod(
        Invocation.method(
          #createUpdateFilter,
          [entity],
        ),
        returnValue: _FakeWorkoutDetailEntityFilter_2(
          this,
          Invocation.method(
            #createUpdateFilter,
            [entity],
          ),
        ),
      ) as _i4.WorkoutDetailEntityFilter);

  @override
  _i6.Future<_i5.DaoResult<List<_i3.WorkoutDetailEntity>>> findAll() =>
      (super.noSuchMethod(
        Invocation.method(
          #findAll,
          [],
        ),
        returnValue:
            _i6.Future<_i5.DaoResult<List<_i3.WorkoutDetailEntity>>>.value(
                _FakeDaoResult_3<List<_i3.WorkoutDetailEntity>>(
          this,
          Invocation.method(
            #findAll,
            [],
          ),
        )),
      ) as _i6.Future<_i5.DaoResult<List<_i3.WorkoutDetailEntity>>>);

  @override
  _i6.Future<_i5.DaoResult<List<_i3.WorkoutDetailEntity>>> findByFilter(
          _i7.DaoFilter? filter) =>
      (super.noSuchMethod(
        Invocation.method(
          #findByFilter,
          [filter],
        ),
        returnValue:
            _i6.Future<_i5.DaoResult<List<_i3.WorkoutDetailEntity>>>.value(
                _FakeDaoResult_3<List<_i3.WorkoutDetailEntity>>(
          this,
          Invocation.method(
            #findByFilter,
            [filter],
          ),
        )),
      ) as _i6.Future<_i5.DaoResult<List<_i3.WorkoutDetailEntity>>>);

  @override
  _i6.Future<_i5.DaoResult<int>> add(_i3.WorkoutDetailEntity? entity) =>
      (super.noSuchMethod(
        Invocation.method(
          #add,
          [entity],
        ),
        returnValue: _i6.Future<_i5.DaoResult<int>>.value(_FakeDaoResult_3<int>(
          this,
          Invocation.method(
            #add,
            [entity],
          ),
        )),
      ) as _i6.Future<_i5.DaoResult<int>>);

  @override
  _i6.Future<_i5.DaoResult<bool>> update(_i3.WorkoutDetailEntity? entity) =>
      (super.noSuchMethod(
        Invocation.method(
          #update,
          [entity],
        ),
        returnValue:
            _i6.Future<_i5.DaoResult<bool>>.value(_FakeDaoResult_3<bool>(
          this,
          Invocation.method(
            #update,
            [entity],
          ),
        )),
      ) as _i6.Future<_i5.DaoResult<bool>>);

  @override
  _i6.Future<_i5.DaoResult<bool>> delete(_i7.DaoFilter? filter) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [filter],
        ),
        returnValue:
            _i6.Future<_i5.DaoResult<bool>>.value(_FakeDaoResult_3<bool>(
          this,
          Invocation.method(
            #delete,
            [filter],
          ),
        )),
      ) as _i6.Future<_i5.DaoResult<bool>>);

  @override
  _i6.Future<void> init(_i6.Future<_i2.Database>? database) =>
      (super.noSuchMethod(
        Invocation.method(
          #init,
          [database],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
}