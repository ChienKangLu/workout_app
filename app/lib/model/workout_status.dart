import '../util/log_util.dart';

enum WorkoutStatus {
  created,
  inProgress,
  finished,
  unknown;

  static const _tag = "WorkoutStatus";

  static WorkoutStatus fromDateTime(
      DateTime? startDateTime, DateTime? endDateTime) {
    if (startDateTime == null && endDateTime == null) {
      return created;
    } else if (startDateTime != null && endDateTime == null) {
      return inProgress;
    } else if (startDateTime != null && endDateTime != null) {
      return finished;
    }

    Log.e(
      _tag,
      "[fromDateTime] startDateTime must be non null if endDateTime is set, startDateTime: $startDateTime, endDateTime: $endDateTime",
    );
    return WorkoutStatus.unknown;
  }
}
