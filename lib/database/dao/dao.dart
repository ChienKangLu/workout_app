import 'dart:async';

import 'package:sqflite/sqflite.dart';

import '../model/base_entity.dart';
import 'dao_filter.dart';

abstract class Dao<T extends BaseEntity, F extends DaoFilter> {
  static int invalidId = -1;

  Future<void> init(Future<Database> database);

  Future<List<T>> findAll();

  Future<List<T>> findByFilter(F? filter);

  Future<int> add(T entity);

  Future<bool> update(T entity);
}