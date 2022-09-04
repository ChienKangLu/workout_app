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

class WorkoutTypeTable {
  static const String name = "workout_type";
  static const String columnId = "id";
  static const String columnName = "name";

  static const create = '''$createTable $name(
    $columnId $primaryKeyInteger, 
    $columnName $text $notNull $unique
  )
  ''';
}

class ExerciseTypeTable {
  static const String name = "exercise_type";
  static const String columnId = "id";
  static const String columnWorkoutTypeId = "workout_type_id";
  static const String columnName = "name";

  static const create = '''$createTable $name(
    $columnId $primaryKeyInteger,
    $columnWorkoutTypeId $integer,
    $columnName $text $notNull $unique,
    $foreignKey($columnWorkoutTypeId) $references ${WorkoutTypeTable.name}(${WorkoutTypeTable.columnId})
  )
  ''';
}

class WorkoutRecordTable {
  static const String name = "workout_record";
  static const String columnId = "id";
  static const String columnWorkoutTypeId = "workout_type_id";
  static const String columnStartDateTime = "start_date_time";
  static const String columnEndDateTime = "end_date_time";

  static const create = '''$createTable $name(
    $columnId $primaryKeyInteger,
    $columnWorkoutTypeId $integer,
    $columnStartDateTime $dateTimeType,
    $columnEndDateTime $dateTimeType,
    $foreignKey($columnWorkoutTypeId) $references ${WorkoutTypeTable.name}(${WorkoutTypeTable.columnId})
  )''';
}

class WeightTrainingSetTable {
  static const String name = "weight_training_set";
  static const String columnRecordId = "record_id";
  static const String columnExerciseTypeId = "exercise_type_id";
  static const String columnBaseWeight = "base_weight";
  static const String columnSideWeight = "side_weight";
  static const String columnRepetition = "repetition";
  static const String columnDateTime = "date_time";

  static const create = '''$createTable $name(
    $columnRecordId $integer,
    $columnExerciseTypeId $integer,
    $columnBaseWeight $real $notNull,
    $columnSideWeight $real $notNull,
    $columnRepetition $integer $notNull,
    $columnDateTime $dateTimeType,
    $foreignKey($columnRecordId) $references ${WorkoutRecordTable.name}(${WorkoutRecordTable.columnId}),
    $foreignKey($columnExerciseTypeId) $references ${ExerciseTypeTable.name}(${ExerciseTypeTable.columnId}),
    $primaryKey($columnRecordId, $columnExerciseTypeId)
  )''';
}

class RunningSetTable {
  static const String name = "running_set";
  static const String columnRecordId = "record_id";
  static const String columnExerciseTypeId = "exercise_type_id";
  static const String columnDuration = "duration";
  static const String columnDistance = "distance";
  static const String columnDateTime = "date_time";

  static const create = '''$createTable $name(
    $columnRecordId $integer,
    $columnExerciseTypeId $integer,
    $columnDuration $real $notNull,
    $columnDistance $real $notNull,
    $columnDateTime $dateTimeType,
    $foreignKey($columnRecordId) $references ${WorkoutRecordTable.name}(${WorkoutRecordTable.columnId}),
    $foreignKey($columnExerciseTypeId) $references ${ExerciseTypeTable.name}(${ExerciseTypeTable.columnId}),
    $primaryKey($columnRecordId, $columnExerciseTypeId)
  )''';
}