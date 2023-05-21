import '../model/running_set_entity.dart';
import '../schema.dart';
import 'simple_dao.dart';

class RunningSetDao
    extends SimpleDao<RunningSetEntity, RunningSetEntityFilter> {
  static const _tag = "RunningSetDao";

  @override
  String get tableName => RunningSetTable.name;

  @override
  String get tag => _tag;

  @override
  RunningSetEntity createEntityFromMap(Map<String, dynamic> map) =>
      RunningSetEntity.fromMap(map);

  @override
  RunningSetEntityFilter createUpdateFilter(RunningSetEntity entity) {
    throw UnimplementedError();
  }
}

class RunningSetEntityFilter extends SimpleEntityFilter {
  RunningSetEntityFilter({
    super.ids,
    super.id,
  });

  @override
  String get columnId => RunningSetTable.columnWorkoutId;
}
