import 'dart:io' as io;

import 'package:flutter_test/flutter_test.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:mockito/mockito.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:workout_app/port/google_drive_port.dart';
import 'package:workout_app/port/model/port_file.dart';

import '../mock/drive_api.mocks.dart';
import '../mock/drive_api_factory.mocks.dart';
import '../mock/google_sign_in_port.mocks.dart';
import '../mock/http_client.mocks.dart';
import '../mock/media.mocks.dart';
import '../util/fake_path_provider_platform.dart';

void main() {
  const folderName = "WorkoutEasy";
  const folderId = "1";
  final apiFolder = File(name: folderName, id: folderId);

  const rawFileName = "workout_database.db";
  const rawFileId = "2";
  final rawFile = io.File(rawFileName);
  final apiFile = File(name: rawFileName, id: rawFileId);
  const portFile = PortFile(rawFileId, rawFileName);

  late MockGoogleSignInPort mockGoogleSignInPort;
  late MockDriveApiFactory mockDriveApiFactory;
  late MockDriveApi mockDriveApi;
  late GoogleDrivePort tested;
  late MockFilesResource mockFilesResource;

  setUp(() {
    mockGoogleSignInPort = MockGoogleSignInPort();
    mockDriveApiFactory = MockDriveApiFactory();
    mockDriveApi = MockDriveApi();
    mockFilesResource = MockFilesResource();

    GoogleDrivePort.setUpDriveApiFactory(mockDriveApiFactory);
    when(mockDriveApiFactory.create(any)).thenAnswer((_) async => mockDriveApi);
    when(mockDriveApi.files).thenReturn(mockFilesResource);

    tested = GoogleDrivePort();
  });

  void setUpApiFolderCreation(File folder) {
    when(mockFilesResource.create(any)).thenAnswer((_) async => folder);
  }

  void setUpApiFileCreation(File file) {
    when(mockFilesResource.create(
      any,
      uploadMedia: argThat(isNotNull, named: "uploadMedia"),
    )).thenAnswer((_) async => file);
  }

  void setUpApiFileList(FileList fileList) {
    when(
      mockFilesResource.list(
        q: argThat(isNotNull, named: "q"),
        $fields: argThat(isNotNull, named: "\$fields"),
      ),
    ).thenAnswer((_) async => fileList);
  }

  FakePathProviderPlatform initFakePathProviderPlatform() {
    TestWidgetsFlutterBinding.ensureInitialized();
    final fakePathProviderPlatform = FakePathProviderPlatform();
    PathProviderPlatform.instance = fakePathProviderPlatform;
    return fakePathProviderPlatform;
  }

  test('Get instance', () {
    // THEN
    expect(GoogleDrivePort.instance, isNotNull);
  });

  test('Create drive api failed', () async {
    // GIVEN
    when(mockGoogleSignInPort.httpClient).thenAnswer((_) async => null);

    // WHEN
    final driveApi = await DriveApiFactory().create(mockGoogleSignInPort);

    // THEN
    expect(driveApi, isNull);
  });

  test('Create drive api successfully', () async {
    // GIVEN
    when(mockGoogleSignInPort.httpClient).thenAnswer((_) async => MockClient());

    // WHEN
    final driveApi = await DriveApiFactory().create(mockGoogleSignInPort);

    // THEN
    expect(driveApi, isNotNull);
  });

  test('upload while drive API is null', () async {
    // GIVEN
    when(mockDriveApiFactory.create(any)).thenAnswer((_) async => null);

    // WHEN
    final result = await tested.upload(folderName, rawFile);

    // THEN
    expect(result, false);
  });

  test('upload while folder ID is not existed', () async {
    // GIVEN
    setUpApiFolderCreation(File(id: null));

    // WHEN
    final result = await tested.upload(folderName, rawFile);

    // THEN
    expect(result, false);
  });

  test('upload file which is not existed locally', () async {
    // GIVEN
    setUpApiFolderCreation(apiFolder);
    setUpApiFileCreation(apiFile);

    // WHEN
    final result = await tested.upload(folderName, rawFile);

    // THEN
    expect(result, false);
  });

  test('upload file successfully', () async {
    // GIVEN
    setUpApiFolderCreation(apiFolder);
    setUpApiFileCreation(apiFile);

    // WHEN
    await rawFile.create();
    final result = await tested.upload(folderName, rawFile);
    await rawFile.delete();

    // THEN
    expect(result, true);
  });

  test('get file list while drive API is null', () async {
    // GIVEN
    when(mockDriveApiFactory.create(any)).thenAnswer((_) async => null);

    // WHEN
    final result = await tested.getFileList(folderName);

    // THEN
    expect(result, []);
  });

  test('get file list while folder ID is not existed', () async {
    // GIVEN
    setUpApiFolderCreation(File(id: null));

    // WHEN
    final result = await tested.getFileList(folderName);

    // THEN
    expect(result, []);
  });

  test('get file list while folder is empty', () async {
    // GIVEN
    setUpApiFolderCreation(apiFolder);
    setUpApiFileList(FileList());

    // WHEN
    final result = await tested.getFileList(folderName);

    // THEN
    expect(result, []);
  });

  test('get file list successfully', () async {
    // GIVEN
    setUpApiFolderCreation(apiFolder);
    setUpApiFileList(FileList(files: [apiFile]));

    // WHEN
    final result = await tested.getFileList(folderName);

    // THEN
    expect(result, [portFile]);
  });

  test('download while drive API is null', () async {
    // GIVEN
    when(mockDriveApiFactory.create(any)).thenAnswer((_) async => null);

    // WHEN
    final result = await tested.download(portFile);

    // THEN
    expect(result, null);
  });

  test('download successfully', () async {
    // GIVEN
    final fakePathProviderPlatform = initFakePathProviderPlatform();
    final temporaryPath = (await fakePathProviderPlatform.getTemporaryPath())!;
    final temporaryDir = io.Directory(temporaryPath);

    final mockMedia = MockMedia();
    when(
      mockMedia.stream
    ).thenAnswer((_) => Stream.value([1, 2, 3]));
    when(
      mockFilesResource.get(
        any,
        downloadOptions: argThat(
          equals(DownloadOptions.fullMedia),
          named: "downloadOptions",
        ),
      ),
    ).thenAnswer((_) async => mockMedia);

    // WHEN
    await temporaryDir.create();
    final result = await tested.download(portFile);
    await temporaryDir.delete(recursive: true);

    // THEN
    expect(result?.path, "$temporaryPath/${portFile.name}");
  });
}
