// Mocks generated by Mockito 5.4.2 from annotations
// in workout_app/test/mock/database_initializer.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i2;
import 'package:workout_app/database/database_initializer.dart' as _i3;

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

/// A class which mocks [DatabaseInitializer].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseInitializer extends _i1.Mock
    implements _i3.DatabaseInitializer {
  MockDatabaseInitializer() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get dbPath => (super.noSuchMethod(
        Invocation.getter(#dbPath),
        returnValue: '',
      ) as String);

  @override
  int get version => (super.noSuchMethod(
        Invocation.getter(#version),
        returnValue: 0,
      ) as int);

  @override
  _i4.Future<_i2.Database> open() => (super.noSuchMethod(
        Invocation.method(
          #open,
          [],
        ),
        returnValue: _i4.Future<_i2.Database>.value(_FakeDatabase_0(
          this,
          Invocation.method(
            #open,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Database>);

  @override
  void setUpDbPath(String? dbPath) => super.noSuchMethod(
        Invocation.method(
          #setUpDbPath,
          [dbPath],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Future<void> onConfigure(_i2.Database? database) => (super.noSuchMethod(
        Invocation.method(
          #onConfigure,
          [database],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> onCreate(
    _i2.Database? database,
    int? version,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #onCreate,
          [
            database,
            version,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> onUpgrade(
    _i2.Database? database,
    int? oldVersion,
    int? newVersion,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #onUpgrade,
          [
            database,
            oldVersion,
            newVersion,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> onOpen(_i2.Database? database) => (super.noSuchMethod(
        Invocation.method(
          #onOpen,
          [database],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}