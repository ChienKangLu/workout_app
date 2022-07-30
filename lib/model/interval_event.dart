class IntervalEvent {
  DateTime? startTime;
  DateTime? endTime;
  
  void startEvent() {
    startTime = DateTime.now();
  }

  void finishEvent() {
    endTime = DateTime.now();
  }
}