class DateTimeUtil {
  static DateTime? fromMicrosecondsSinceEpoch(int? microsecondsSinceEpoch) =>
      microsecondsSinceEpoch != null
          ? DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch)
          : null;
}
