const integer = "INTEGER";
const real = "REAL";
const text = "TEXT";

const dateTime = integer;

const createTable = "CREATE TABLE IF NOT EXISTS";
const primaryKey = "PRIMARY KEY";
const primaryKeyInteger = "$integer PRIMARY KEY";
const foreignKey = "FOREIGN KEY";
const references = "REFERENCES";
const notNull = "NOT NUll";
const unique = "UNIQUE";

const ignoredId = -1;

class WorkoutRecordTable {
  static const String name = "workout_record";
  static const String columnWorkoutRecordId = "workout_record_id";
  static const String columnWorkoutTypeId = "workout_type_id";
  static const String columnStartDateTime = "start_date_time";
  static const String columnEndDateTime = "end_date_time";

  static const create = '''$createTable $name(
    $columnWorkoutRecordId $primaryKeyInteger,
    $columnWorkoutTypeId $integer,
    $columnStartDateTime $dateTime,
    $columnEndDateTime $dateTime
  )''';
}

class ExerciseTable {
  static const String name = "exercise";
  static const String columnExerciseId = "exercise_id";
  static const String columnWorkoutTypeId = "workout_type_id";
  static const String columnExerciseName = "exercise_name";

  static const create = '''$createTable $name(
    $columnExerciseId $primaryKeyInteger,
    $columnWorkoutTypeId $integer,
    $columnExerciseName $text $notNull $unique
  )
  ''';
}

class WeightTrainingTable {
  static const String name = "weight_training";
  static const String columnWorkoutRecordId = "workout_record_id";
  static const String columnExerciseId = "exercise_id";
  static const String columnSetNum = "set_num";
  static const String columnBaseWeight = "base_weight";
  static const String columnSideWeight = "side_weight";
  static const String columnRepetition = "repetition";
  static const String columnEndDateTime = "end_date_time";

  static const create = '''$createTable $name(
    $columnWorkoutRecordId $integer,
    $columnExerciseId $integer,
    $columnSetNum $integer,
    $columnBaseWeight $real $notNull,
    $columnSideWeight $real $notNull,
    $columnRepetition $integer $notNull,
    $columnEndDateTime $dateTime,
    $foreignKey($columnWorkoutRecordId) $references ${WorkoutRecordTable.name}(${WorkoutRecordTable.columnWorkoutRecordId}),
    $foreignKey($columnExerciseId) $references ${ExerciseTable.name}(${ExerciseTable.columnExerciseId}),
    $primaryKey($columnWorkoutRecordId, $columnExerciseId, $columnSetNum)
  )''';
}

class RunningTable {
  static const String name = "running";
  static const String columnWorkoutRecordId = "workout_record_id";
  static const String columnExerciseId = "exercise_id";
  static const String columnSetNum = "set_num";
  static const String columnDuration = "duration";
  static const String columnDistance = "distance";
  static const String columnEndDateTime = "end_date_time";

  static const create = '''$createTable $name(
    $columnWorkoutRecordId $integer,
    $columnExerciseId $integer,
    $columnSetNum $integer,
    $columnDuration $real $notNull,
    $columnDistance $real $notNull,
    $columnEndDateTime $dateTime,
    $foreignKey($columnWorkoutRecordId) $references ${WorkoutRecordTable.name}(${WorkoutRecordTable.columnWorkoutRecordId}),
    $foreignKey($columnExerciseId) $references ${ExerciseTable.name}(${ExerciseTable.columnExerciseId}),
    $primaryKey($columnWorkoutRecordId, $columnExerciseId, $columnSetNum)
  )''';
}