import 'package:flutter/material.dart';

import '../../util/date_time_util.dart';

class WorkoutTimer extends StatefulWidget {
  const WorkoutTimer._({
    Key? key,
    required this.isTicking,
    this.dateTime,
    this.duration,
  }) : super(key: key);

  const WorkoutTimer.ticking({
    Key? key,
    required DateTime? dateTime,
  }) : this._(
          key: key,
          isTicking: true,
          dateTime: dateTime,
        );

  const WorkoutTimer.finished({
    Key? key,
    required Duration duration,
  }) : this._(
          key: key,
          isTicking: false,
          duration: duration,
        );

  final bool isTicking;
  final DateTime? dateTime;
  final Duration? duration;

  @override
  State<WorkoutTimer> createState() => _WorkoutTimerState();
}

class _WorkoutTimerState extends State<WorkoutTimer>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  bool get isTicking => widget.isTicking;
  DateTime? get _dateTime => widget.dateTime;
  Duration? get _duration => widget.duration;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );

    if (isTicking) {
      controller.repeat();
    }

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final duration = _duration;
    if (duration != null) {
      return _timer(duration);
    }

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final dateTime = _dateTime;
        final duration = dateTime == null
            ? Duration.zero
            : DateTime.now().difference(dateTime);

        return _timer(duration);
      },
    );
  }

  Widget _timer(Duration duration) {
    return Text(
      DateTimeUtil.durationString(duration),
      style: Theme.of(context).textTheme.displayLarge,
    );
  }
}
