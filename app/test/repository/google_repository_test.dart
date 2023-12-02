import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:workout_app/port/google_drive_port.dart';
import 'package:workout_app/port/google_sign_in_port.dart';
import 'package:workout_app/port/model/port_file.dart';
import 'package:workout_app/repository/google_repository.dart';

import '../mock/google_drive_port.mocks.dart';
import '../mock/google_sign_in_port.mocks.dart';

void main() {
  late MockGoogleSignInPort mockGoogleSignInPort;
  late MockGoogleDrivePort mockGoogleDrivePort;
  late GoogleRepository tested;

  setUp(() {
    mockGoogleSignInPort = MockGoogleSignInPort();
    mockGoogleDrivePort = MockGoogleDrivePort();

    GoogleSignInPort.setUpInstance(mockGoogleSignInPort);
    GoogleDrivePort.setUpInstance(mockGoogleDrivePort);

    tested = GoogleRepository();
  });

  test('Upload file while not sign in', () async {
    // GIVEN
    const folder = "folder";
    final file = File("file");
    when(mockGoogleSignInPort.signIn())
        .thenAnswer((realInvocation) async => false);

    // WHEN
    final result = await tested.uploadFile(folder, file);

    // THEN
    expect(result, false);
  });

  test('Upload file failed while sign in', () async {
    // GIVEN
    const folder = "folder";
    final file = File("file");
    when(mockGoogleSignInPort.signIn())
        .thenAnswer((realInvocation) async => true);
    when(mockGoogleDrivePort.upload(folder, file))
        .thenAnswer((realInvocation) async => false);

    // WHEN
    final result = await tested.uploadFile(folder, file);

    // THEN
    expect(result, false);
  });

  test('Upload file successfully while sign in', () async {
    // GIVEN
    const folder = "folder";
    final file = File("file");
    when(mockGoogleSignInPort.signIn()).thenAnswer((_) async => true);
    when(mockGoogleDrivePort.upload(folder, file))
        .thenAnswer((_) async => true);

    // WHEN
    final result = await tested.uploadFile(folder, file);

    // THEN
    expect(result, true);
  });

  test('Get file list while not sign in', () async {
    // GIVEN
    const folder = "folder";
    when(mockGoogleSignInPort.signIn()).thenAnswer((_) async => false);

    // WHEN
    final result = await tested.getFileList(folder);

    // THEN
    expect(result, []);
  });

  test('Get file list while sign in', () async {
    // GIVEN
    const folder = "folder";
    const portFile = PortFile("1", "file");
    when(mockGoogleSignInPort.signIn()).thenAnswer((_) async => true);
    when(mockGoogleDrivePort.getFileList(folder)).thenAnswer(
      (_) async => [portFile],
    );

    // WHEN
    final result = await tested.getFileList(folder);

    // THEN
    expect(result, [portFile]);
  });

  test('Download while not sign in', () async {
    // GIVEN
    const portFile = PortFile("1", "file");
    when(mockGoogleSignInPort.signIn()).thenAnswer((_) async => false);

    // WHEN
    final result = await tested.download(portFile);

    // THEN
    expect(result, null);
  });

  test('Download while not sign in', () async {
    // GIVEN
    const portFile = PortFile("1", "file");
    final file = File("file");
    when(mockGoogleSignInPort.signIn()).thenAnswer((_) async => true);
    when(mockGoogleDrivePort.download(portFile)).thenAnswer((_) async => file);

    // WHEN
    final result = await tested.download(portFile);

    // THEN
    expect(result, file);
  });
}
