const integer = "INTEGER";
const real = "REAL";
const text = "TEXT";

const dateTimeType = integer;

const createTable = "CREATE TABLE IF NOT EXISTS";
const primaryKey = "PRIMARY KEY";
const primaryKeyInteger = "$integer PRIMARY KEY";
const foreignKey = "FOREIGN KEY";
const references = "REFERENCES";
const notNull = "NOT NUll";
const unique = "UNIQUE";

const ignoredId = -1;

class WorkoutTable {
  static const String name = "workout";
  static const String columnId = "id";
  static const String columnName = "name";

  static const create = '''$createTable $name(
    $columnId $primaryKeyInteger, 
    $columnName $text $notNull $unique
  )
  ''';
}

class ExerciseTable {
  static const String name = "exercise";
  static const String columnId = "id";
  static const String columnWorkoutId = "workout_id";
  static const String columnName = "name";

  static const create = '''$createTable $name(
    $columnId $primaryKeyInteger,
    $columnWorkoutId $integer,
    $columnName $text $notNull $unique,
    $foreignKey($columnWorkoutId) $references ${WorkoutTable.name}(${WorkoutTable.columnId})
  )
  ''';
}

class RecordTable {
  static const String name = "record";
  static const String columnId = "id";
  static const String columnWorkoutId = "workout_id";
  static const String columnStartDateTime = "start_date_time";
  static const String columnEndDateTime = "end_date_time";

  static const create = '''$createTable $name(
    $columnId $primaryKeyInteger,
    $columnWorkoutId $integer,
    $columnStartDateTime $dateTimeType,
    $columnEndDateTime $dateTimeType,
    $foreignKey($columnWorkoutId) $references ${WorkoutTable.name}(${WorkoutTable.columnId})
  )''';
}

class WeightTrainingSetTable {
  static const String name = "weight_training_set";
  static const String columnRecordId = "record_id";
  static const String columnExerciseId = "exercise_id";
  static const String columnBaseWeight = "base_weight";
  static const String columnSideWeight = "side_weight";
  static const String columnRepetition = "repetition";
  static const String columnDateTime = "date_time";

  static const create = '''$createTable $name(
    $columnRecordId $integer,
    $columnExerciseId $integer,
    $columnBaseWeight $real $notNull,
    $columnSideWeight $real $notNull,
    $columnRepetition $integer $notNull,
    $columnDateTime $dateTimeType,
    $foreignKey($columnRecordId) $references ${RecordTable.name}(${RecordTable.columnId}),
    $foreignKey($columnExerciseId) $references ${ExerciseTable.name}(${ExerciseTable.columnId}),
    $primaryKey($columnRecordId, $columnExerciseId)
  )''';
}

class RunningSetTable {
  static const String name = "running_set";
  static const String columnRecordId = "record_id";
  static const String columnExerciseId = "exercise_id";
  static const String columnDuration = "duration";
  static const String columnDistance = "distance";
  static const String columnDateTime = "date_time";

  static const create = '''$createTable $name(
    $columnRecordId $integer,
    $columnExerciseId $integer,
    $columnDuration $real $notNull,
    $columnDistance $real $notNull,
    $columnDateTime $dateTimeType,
    $foreignKey($columnRecordId) $references ${RecordTable.name}(${RecordTable.columnId}),
    $foreignKey($columnExerciseId) $references ${ExerciseTable.name}(${ExerciseTable.columnId}),
    $primaryKey($columnRecordId, $columnExerciseId)
  )''';
}