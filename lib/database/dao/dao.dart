import 'dart:async';

import 'package:sqflite/sqflite.dart';

abstract class Dao<T> {
  Future<void> init(Future<Database> database, bool firstCreation);

  Future<void> insert (T entity);

  Future<List<T>> getAll();
}