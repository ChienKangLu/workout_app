import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/model/water_goal.dart';

void main() {
  const id = 1;
  const volume = 500.0;
  final dateTime = DateTime(1970);

  late WaterGoal tested;

  setUp(() {
    tested = WaterGoal(id: id, volume: volume, dateTime: dateTime);
  });

  test('Init', () async {
    // THEN
    expect(tested.id, id);
    expect(tested.volume, volume);
    expect(tested.dateTime, dateTime);
  });
}
