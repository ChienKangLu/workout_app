import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

//ignore: must_be_immutable
class IntervalEvent extends Equatable {
  IntervalEvent({DateTime? startDateTime, DateTime? endDateTime}) {
    _startDateTime = startDateTime;
    _endDateTime = endDateTime;
  }

  DateTime? _startDateTime;
  DateTime? get startDateTime => _startDateTime;
  DateTime? _endDateTime;
  DateTime? get endDateTime => _endDateTime;

  void startEvent() => _startDateTime = DateTime.now();

  void finishEvent() => _endDateTime = DateTime.now();

  @override
  List<Object?> get props => [
        _startDateTime?.millisecondsSinceEpoch,
        _endDateTime?.millisecondsSinceEpoch,
      ];

  @visibleForTesting
  void setStartDateTime(DateTime dateTime) {
    _startDateTime = dateTime;
  }

  @visibleForTesting
  void setEndDateTime(DateTime dateTime) {
    _endDateTime = dateTime;
  }
}
