class IntervalEvent {
  // TODO: remove mock time once database ready
  DateTime? startTime = DateTime.now();
  DateTime? endTime = DateTime.now().add(const Duration(hours: 1, minutes: 25, seconds: 30, milliseconds: 105));

  void startEvent() {
    startTime = DateTime.now();
  }

  void finishEvent() {
    endTime = DateTime.now();
  }
}