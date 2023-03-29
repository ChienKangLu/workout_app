import 'package:sqflite/sqflite.dart';

import '../../util/log_util.dart';
import '../model/base_entity.dart';
import 'base_dao.dart';
import 'dao_filter.dart';
import 'dao_result.dart';

abstract class SimpleDao<T extends BaseEntity, F extends SimpleEntityFilter>
    extends BaseDao<T, F> {
  String get tag;
  String get tableName;

  T createEntityFromMap(Map<String, dynamic> map);
  F createUpdateFilter(T entity);

  @override
  Future<DaoResult<List<T>>> findAll() async {
    try {
      final maps = await database.query(tableName);
      final results = <T>[];
      for (final map in maps) {
        results.add(createEntityFromMap(map));
      }

      return DaoSuccess(results);
    } on Exception catch (e) {
      Log.e(tag, "Cannot findAll", e);
      return DaoError(e);
    }
  }

  @override
  Future<DaoResult<List<T>>> findByFilter(
    SimpleEntityFilter? filter,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<DaoResult<int>> add(T entity) async {
    try {
      final id = await database.insert(
        tableName,
        entity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );

      return DaoSuccess(id);
    } on Exception catch (e) {
      Log.e(tag, "Cannot add entity '$entity'", e);
      return DaoError(e);
    }
  }

  @override
  Future<DaoResult<bool>> update(T entity) async {
    try {
      final entityMap = entity.toMap();

      final count = await database.update(
        tableName,
        entityMap,
        where: createUpdateFilter(entity).toWhereClause(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      Log.d(tag, "Update $count rows in '$tableName'");

      return DaoSuccess(true);
    } on Exception catch (e) {
      Log.e(tag, "Cannot add entity '$entity'", e);
      return DaoError(e);
    }
  }

  @override
  Future<DaoResult<bool>> delete(SimpleEntityFilter filter) async {
    try {
      final count = await database.delete(
        tableName,
        where: filter.toWhereClause(),
      );
      Log.d(tag, "Delete $count rows from '$tableName'");

      return DaoSuccess(true);
    } on Exception catch (e) {
      Log.e(tag, "Cannot findByFilter with filter '$filter'", e);
      return DaoError(e);
    }
  }
}

abstract class SimpleEntityFilter implements DaoFilter {
  SimpleEntityFilter({
    this.ids = const [],
    this.id,
  });

  final List<int> ids;
  final int? id;

  String get columnId;

  @override
  String? toWhereClause() {
    final where = <String>[];
    if (ids.isNotEmpty) {
      final args = ids.join(",");
      where.add("$columnId in ($args)");
    }
    if (id != null) {
      where.add("$columnId = $id");
    }

    if (where.isEmpty) {
      return null;
    }

    return where.join(" AND ");
  }
}
