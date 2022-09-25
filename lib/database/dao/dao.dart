import 'dart:async';

import 'package:sqflite/sqflite.dart';

abstract class Dao<T> {
  Future<void> init(Future<Database> database);
}
