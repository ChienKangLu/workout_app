enum WorkoutStatus{
  created, inProgress, finished;

  static WorkoutStatus fromDateTime(DateTime? startDateTime, DateTime? endDateTime) {
    if (startDateTime == null && endDateTime == null) {
      return created;
    } else if (startDateTime != null && endDateTime == null) {
      return inProgress;
    } else if (startDateTime != null && endDateTime != null) {
      return finished;
    } else {
      throw Exception("Error status: startDateTime must be non null if endDateTime is set");
    }
  }
}