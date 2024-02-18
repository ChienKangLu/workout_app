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

const ignored = -1;

class WorkoutTable {
  static const String name = "workout";
  static const String columnWorkoutId = "workout_id";
  static const String columnWorkoutCreateDateTime = "workout_create_date_time";
  static const String columnWorkoutStartDateTime = "workout_start_date_time";
  static const String columnWorkoutEndDateTime = "workout_end_date_time";

  static const create = '''$createTable $name(
    $columnWorkoutId $primaryKeyInteger,
    $columnWorkoutCreateDateTime $dateTime,
    $columnWorkoutStartDateTime $dateTime,
    $columnWorkoutEndDateTime $dateTime
  )''';
}

class ExerciseTable {
  static const String name = "exercise";
  static const String columnExerciseId = "exercise_id";
  static const String columnExerciseName = "exercise_name";

  static const create = '''$createTable $name(
    $columnExerciseId $primaryKeyInteger,
    $columnExerciseName $text $notNull $unique
  )''';
}

class WorkoutDetailTable {
  static const String name = "workout_detail";
  static const String columnWorkoutId = "workout_id";
  static const String columnExerciseId = "exercise_id";
  static const String columnExerciseCreateDateTime = "exercise_create_date_time";

  static const create = '''$createTable $name(
    $columnWorkoutId $integer,
    $columnExerciseId $integer,
    $columnExerciseCreateDateTime $dateTime,
    $foreignKey($columnWorkoutId) $references ${WorkoutTable.name}(${WorkoutTable.columnWorkoutId}),
    $foreignKey($columnExerciseId) $references ${ExerciseTable.name}(${ExerciseTable.columnExerciseId}),
    $primaryKey($columnWorkoutId, $columnExerciseId)
  )''';
}

class ExerciseSetTable {
  static const String name = "exercise_set";
  static const String columnWorkoutId = "workout_id";
  static const String columnExerciseId = "exercise_id";
  static const String columnSetNum = "set_num";
  static const String columnBaseWeight = "base_weight";
  static const String columnSideWeight = "side_weight";
  static const String columnRepetition = "repetition";
  static const String columnSetEndDateTime = "set_end_date_time";

  static const create = '''$createTable $name(
    $columnWorkoutId $integer,
    $columnExerciseId $integer,
    $columnSetNum $integer,
    $columnBaseWeight $real $notNull,
    $columnSideWeight $real $notNull,
    $columnRepetition $integer $notNull,
    $columnSetEndDateTime $dateTime,
    $foreignKey($columnWorkoutId) $references ${WorkoutTable.name}(${WorkoutTable.columnWorkoutId}),
    $foreignKey($columnExerciseId) $references ${ExerciseTable.name}(${ExerciseTable.columnExerciseId}),
    $primaryKey($columnWorkoutId, $columnExerciseId, $columnSetNum)
  )''';
}

class WaterLogTable {
  static const String name = "water_log";
  static const String columnWaterLogId = "water_log_id";
  static const String columnWaterLogVolume = "water_log_volume";
  static const String columnWaterLogDateTime = "water_log_date_time";

  static const create = '''$createTable $name(
    $columnWaterLogId $primaryKeyInteger,
    $columnWaterLogVolume $real,
    $columnWaterLogDateTime $dateTime
  )''';
}

class WaterGoalTable {
  static const String name = "water_goal";
  static const String columnWaterGoalId = "water_goal_id";
  static const String columnWaterGoalVolume = "water_goal_volume";
  static const String columnWaterGoalDateTime = "water_goal_date_time";

  static const create = '''$createTable $name(
    $columnWaterGoalId $primaryKeyInteger,
    $columnWaterGoalVolume $real,
    $columnWaterGoalDateTime $dateTime
  )''';
}