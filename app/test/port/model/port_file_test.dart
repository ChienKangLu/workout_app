import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/port/model/port_file.dart';

void main() {
  const id = "id";
  const name = "file";

  late PortFile tested;

  setUp(() {
    tested = const PortFile(id, name);
  });

  test('Init', () async {
    // THEN
    expect(
      tested,
      const PortFile(id, name),
    );
  });

  test('Equatable', () async {
    // GIVEN
    // ignore: prefer_const_constructors
    final another = PortFile(id, name);

    // WHEN
    final result = another == tested;

    // THEN
    expect(result, true);
  });
}
