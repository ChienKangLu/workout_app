import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

import 'dao.dart';

abstract class BaseDao<T> implements Dao<T> {
  @protected
  late final Database database;

  @override
  Future<void> init(Future<Database> database) async {
    this.database = await database;
  }
}
