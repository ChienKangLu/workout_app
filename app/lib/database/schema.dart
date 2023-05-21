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
  static const String columnWorkoutTypeId = "workout_type_id";
  static const String columnWorkoutTypeNum = "workout_type_num";
  static const String columnWorkoutCreateDateTime = "workout_create_date_time";
  static const String columnWorkoutStartDateTime = "workout_start_date_time";
  static const String columnWorkoutEndDateTime = "workout_end_date_time";

  static const create = '''$createTable $name(
    $columnWorkoutId $primaryKeyInteger,
    $columnWorkoutTypeId $integer,
    $columnWorkoutTypeNum $integer,
    $columnWorkoutCreateDateTime $dateTime,
    $columnWorkoutStartDateTime $dateTime,
    $columnWorkoutEndDateTime $dateTime
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

class WeightTrainingSetTable {
  static const String name = "weight_training_set";
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

class RunningSetTable {
  static const String name = "running_set";
  static const String columnWorkoutId = "workout_id";
  static const String columnExerciseId = "exercise_id";
  static const String columnSetNum = "set_num";
  static const String columnDuration = "duration";
  static const String columnDistance = "distance";
  static const String columnSetEndDateTime = "set_end_date_time";

  static const create = '''$createTable $name(
    $columnWorkoutId $integer,
    $columnExerciseId $integer,
    $columnSetNum $integer,
    $columnDuration $real $notNull,
    $columnDistance $real $notNull,
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

class FoodTable {
  static const String name = "food";
  static const String columnFoodId = "food_id";
  static const String columnFoodBrandName = "food_brand_name";
  static const String columnFoodName = "food_name";
  static const String columnFoodEnergy = "food_energy";
  static const String columnFoodFat = "food_fat";
  static const String columnFoodCarbohydrate = "food_carbohydrate";
  static const String columnFoodProtein = "food_protein";
  static const String columnFoodSodium = "food_sodium";

  static const create = '''$createTable $name(
    $columnFoodId $primaryKeyInteger,
    $columnFoodBrandName $text,
    $columnFoodName $text,
    $columnFoodEnergy $real,
    $columnFoodFat $real,
    $columnFoodCarbohydrate $real,
    $columnFoodProtein $real,
    $columnFoodSodium $real,
  )''';
}

class FoodLogTable {
  static const String name = "food_log";
  static const String columnFoodLogId = "food_log_id";
  static const String columnFoodId = "food_id";
  static const String columnFoodLogDateTime = "food_log_date_time";

  static const create = '''$createTable $name(
    $columnFoodLogId $primaryKeyInteger,
    $columnFoodId $integer,
    $columnFoodLogDateTime $dateTime,
    $foreignKey($columnFoodId) $references ${FoodTable.name}(${FoodTable.columnFoodId})
  )''';
}