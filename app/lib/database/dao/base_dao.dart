import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

import '../model/base_entity.dart';
import 'dao.dart';
import 'dao_filter.dart';

abstract class BaseDao<T extends BaseEntity, F extends DaoFilter>
    implements Dao<T, F> {
  @protected
  late final Database database;

  @override
  Future<void> init(Future<Database> database) async {
    this.database = await database;
  }
}
