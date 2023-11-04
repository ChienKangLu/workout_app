import 'dart:async';

import 'package:sqflite/sqflite.dart';

import '../model/base_entity.dart';
import 'dao_filter.dart';
import 'dao_result.dart';

abstract class Dao<T extends BaseEntity, F extends DaoFilter> {
  Future<void> init(Future<Database> database);

  Future<DaoResult<List<T>>> findAll();

  Future<DaoResult<List<T>>> findByFilter(F? filter);

  Future<DaoResult<int>> add(T entity);

  Future<DaoResult<bool>> update(T entity);

  Future<DaoResult<bool>> delete(F filter);
}