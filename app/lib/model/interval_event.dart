class IntervalEvent {
  DateTime? startDateTime;
  DateTime? endDateTime;

  void startEvent() => startDateTime = DateTime.now();

  void finishEvent() => endDateTime = DateTime.now();
}