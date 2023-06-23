import '../workout_database.dart';
import 'composed_workout_dao.dart';
import 'exercise_dao.dart';
import 'running_set_dao.dart';
import 'water_goal_dao.dart';
import 'water_log_dao.dart';
import 'weight_training_set_dao.dart';
import 'workout_dao.dart';
import 'workout_detail_dao.dart';

mixin DaoProviderMixin {
  WorkoutDatabase get _db => WorkoutDatabase.instance;
  WorkoutDao get workoutDao => _db.workoutDao;
  ExerciseDao get exerciseDao => _db.exerciseDao;
  WorkoutDetailDao get workoutDetailDao => _db.workoutDetailDao;
  WeightTrainingSetDao get weightTrainingSetDao => _db.weightTrainingSetDao;
  RunningSetDao get runningSetDao => _db.runningSetDao;
  ComposedWorkoutDao get composedWorkoutDao => _db.composedWorkoutDao;
  WaterGoalDao get waterGoalDao => _db.waterGoalDao;
  WaterLogDao get waterLogDao => _db.waterLogDao;
}